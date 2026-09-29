# ___PACKAGENAME___ — архитектурные инварианты

## Data direction

```
Storage Entity ↕ Domain Model ↕ ViewModel ↕ ViewState ↕ View
```

Persistence Entity никогда не становится публичной моделью UI.

`___VARIABLE_modelName___Entity`, `@Model`, `ModelContext`, `FetchDescriptor`, `#Predicate`, `@Query`
не должны появляться в App packages.

## Module shape

Модуль состоит из 4 файлов в своей папке:

- `X.swift` — `@Module` enum + `XInput` / `XOutput: Sendable`;
- `XView.swift`;
- `XViewModel.swift`;
- `XViewState.swift`.

Имена совпадают с prefix enum, потому что macro генерирует typealias по имени.
Сборка модуля только через `X.build()` / `X.buildCached()`.

Исключение: модуль `Main` лежит в `MainModule.swift`. Файл `Main.swift` SwiftPM на case-insensitive
файловой системе считает `main.swift`, и таргет становится executable.

Эталонная фича — `Packages/App/Sources/Main/`: `Main` (список, `LoadingState<StateModel>`,
`contentUnavailable`/`errorState`) → `___VARIABLE_modelName___Detail` (`build(input:)` по id).
Subviews модуля — в `<Module>/Subviews/`, каждый с `#Preview`.

Модули фич не называются `*Root`. Root-уровень есть только в `___PACKAGENAME___/App`, `___PACKAGENAME___/Root`,
`___PACKAGENAME___/Navigation`; исключение — `RootTabs` в `Env/Tabs`, чтобы фичи могли переключать вкладки.
Первый экран вкладки называется по вкладке: `Main`, `AppSettings`.

## View

- presentation only;
- user actions → `reducer.callAsFunction(.onSomething)`;
- нет `@Injected`, services и business logic;
- нет `Task { }` с business logic;
- local state только presentation-only (`@FocusState`, `@Namespace`, animation flags);
- новые subviews → `Subviews/`, каждое с `#Preview`.

## ViewState

- `@Observable public final class`;
- `ViewStateProtocol`;
- `init(input:)`;
- всё значимое состояние экрана хранится здесь;
- только Domain models.

## ViewModel

- `@ViewModel public actor`;
- все non-private методы с prefix `on` попадают в Action API;
- helpers обязаны быть `private`;
- state mutation только через `await state.update { ... }`.

## Navigation

Destinations: `public nonisolated enum` в `Env/Destinations/`.

Conformance к `NavigationDestination` — только app target `___PACKAGENAME___/Navigation/`.

`import NavigatorUI` запрещён в `Packages/` без исключений.

Допустим только в `___PACKAGENAME___/`:

- root/entry point;
- `___PACKAGENAME___/Navigation/` conformance.

Feature screens используют только `OversizeNavigation`:

- `navigationOpen(_:)`;
- `navigationMove(_:)`;
- `navigationRoute(_:)`;
- `navigationBack(_:)`;
- `backConfirmationDialog(_:)`;
- `navigationBarAppearanceConfiguration()`;
- `presentationAlert(_:)`;
- `presentationHUD(_:)`;
- `presentationHUDRoot()`;
- `contentUnavailable(...)`;
- `errorState(_:)`;
- `Navigation*Layout`.

Если поведения нет — расширять `OversizeNavigation`, а не протаскивать NavigatorUI в feature.

Ровно **один** `navigationAutoReceive` / `onNavigationReceive` на тип destination во всём дереве.
Второй обработчик того же типа перехватывает значение первым, и навигация молча уходит не в тот stack.
`RootTabs` принимает только `RootView`. Отдельный `delay` не задаётся: следующий шаг цепочки NavigatorUI отправляет через стандартный `executionDelay` (0.3 с), этого хватает, чтобы вкладка смонтировалась (проверено с `.sidebarAdaptable` на iOS 27).

## Swift Concurrency

Swift 6 strict concurrency.

Запрещены:

- `@unchecked Sendable` без отдельного согласованного исключения;
- `Task.detached`;
- семафоры как средство обхода concurrency model.

`Reducer.callAsFunction` внутри создаёт голый `Task { }`, не связанный с lifecycle View и не отменяемый.
Долгие actions требуют cancellation strategy и защиты от повторных нажатий.

`@ObservableDefaults`-хранилища объявляются только так:

```swift
@MainActor
@ObservableDefaults(ignoreExternalChanges: true)
final class Storage: Sendable { ... }
```

Без `ignoreExternalChanges: true` observer `UserDefaults` реентерит активную транзакцию AttributeGraph и роняет приложение (SIGABRT).

## Cached state

`buildCached()` хранит ViewState в global cache по key.
Для parameterized screens (например detail by id) использовать `build(input:)`, если shared cached state не является намеренным.

## Packages

Граф зависимостей (проверяется `make arch-check`):

```
App → Services → Database → Models
App → Models
App → Env (лист)
```

- `Models` — публичные Domain models, без persistence-типов;
- `Database` — `internal` Entities (`Entities/`), `internal` mapping (`Mapping/`), `@ModelActor` storage, DI;
- `App` не зависит от `Database` и не импортирует `SwiftData`;
- `Env` не импортирует app-слои.

## Storage

Storage services возвращают наружу Domain models, а не Entity.
Entity и `ModelContainer` schema остаются `internal` в `Database`.
Ошибки — `PersistenceError`; `itemNotFound` пробрасывается как есть, не превращается в `fetchFailed`/`updateFailed`.
`update` принимает полную Domain model (можно очищать optional поля).
`modelContainerService` в previews и tests — in-memory (`.onPreview` / `.onTest`).

## Services

Направление зависимостей: `App → Services → Database → Models`.

- app services (бизнес-логика, notifications, network) живут в `Packages/Services`;
- это `actor`, регистрируются в `Services/Injection` через Factory;
- storage получают через `@LazyInjected(\.storageService) private var ...` + `public init() {}`: резолв происходит внутри actor, а не на MainActor при init ViewModel, поэтому `@ModelActor` не создаётся на main thread;
- регистрации в DI — scope `.cached` (сбрасывается `FactoryTesting` `.container` trait), не `.singleton`;
- ViewModels инжектят только app services (`\.___VARIABLE_modelVariableName___Service`), не storage;
- работают только с Domain models, SwiftData-типы в `Services` запрещены;
- storage services (`@ModelActor`) в `Services` не переносятся — они часть `Database`.

CloudKit note: до первого prod release схема может меняться без migration, но CloudKit constraints всё равно должны быть валидными.
Уникальные constraints, несовместимые с CloudKit automatic configuration, не вводить.
