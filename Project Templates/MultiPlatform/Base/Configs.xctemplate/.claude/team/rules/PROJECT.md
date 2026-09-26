# ___PACKAGENAME___ — фактическое состояние и инструменты

Этот файл содержит только факты, которые могут изменить решение агента. Источник истины — актуальный код.

## Контекст продукта

- Описание продукта: _заполнить после создания проекта (назначение, целевая аудитория, ключевые сценарии)_.
- Приложение ещё не выпущено в App Store; живых prod-данных нет.
- Миграции SwiftData-схемы сейчас не требуются: breaking changes моделей допустимы до первого релиза.
- Обратная совместимость публичного API самого приложения сейчас не требуется.
- Это НЕ относится к общим пакетам в `$HOME/Developer/Packages`: они используются несколькими проектами и не редактируются из ___PACKAGENAME___.
- CI: Xcode Cloud, `ci_scripts/ci_post_clone.sh` генерирует проект (`FORCE_REMOTE_PACKAGES=1 xcodegen`); локальный основной gate — `make build` + `make test`.

После первого App Store релиза эти допущения нужно пересмотреть.

## Build и tools

Корень проекта: `$HOME/Developer/___PACKAGENAME___`.

- build: `make compile`;
- tests: `make test` (`IOS_DESTINATION` в makefile, scheme `___PACKAGENAME___ (Dev)`);
- formal code review PR: `make review BASE=<base PR>` → `git fetch` + `codex review --base origin/<base>`;
  без `BASE` — `codex review --uncommitted` (только локальные незакоммиченные изменения);
- при сбое make печатает ту же команду `codex review` для повтора без подавления stderr;
- format check: `swiftformat ___PACKAGENAME___ Packages --lint`;
- project generation: `xcodegen` (`make build` регенерирует `___PACKAGENAME___.xcodeproj`; в git проект не хранится);
- architecture guard: `make arch-check` (запрещённые импорты между слоями, входит в `make build`);
- init scripts: `make init-scripts` после изменений в `Packages/`, `make verify-init` проверяет синхронность;
- targets: `Configs/Targets.yml`.

`swiftlint` может быть не установлен — `make lint` / `make lint-fix` не считать quality gate.

Во время Agent workflow `make review` запускает только `code-reviewer`. Developers используют
`make compile` и обычную самопроверку.

## Packages и worktrees

Общие Oversize packages живут в `$HOME/Developer/Packages`.

Это зафиксировано в двух местах:

- `Configs/PackagesLocal.yml`;
- `sharedPackagesPath` в `Packages/{App,Services,Database,Models,Env}/Package.swift`.

Они должны оставаться согласованными. Тулинг (`make format`, `make gen`) общие пакеты не изменяет.

Новые worktrees не требуют отдельного symlink: абсолютные пути уже резолвятся.
`make build-prod` выставляет `FORCE_REMOTE_PACKAGES=1` и принудительно резолвит remote-версии пакетов.

## Фактическая структура приложения

Проект создан из OversizeTemplate; ниже — то, что генерирует шаблон. Обновлять по мере развития продукта.

- `___PACKAGENAME___/App/___PACKAGENAME___App.swift` — только `@main` entry point: `Launcher { RootView() }.onboarding { OnboardingNavigationStack() }`;
- вариант TabBar: `___PACKAGENAME___/Root/RootView.swift` — единственный root: один `TabView` со стилем `.sidebarAdaptable`
  (compact — таб-бар, regular — sidebar), `@SceneStorage` для выбранной вкладки,
  единственный `onNavigationReceive(assign: $selectedTab)` и `.navigationRoot(navigator)`;
  `___PACKAGENAME___/Navigation/Tabs/ResolveTabs.swift` — `RootTabs: @retroactive View`;
  tabs: `.main` (`MainNavigationStack`), `.settings` (`AppSettingsNavigationStack`);
- вариант Basic: `RootView` — один `MainNavigationStack` с `.navigationRoot(navigator)`, без `TabView` и `ResolveTabs`;
  настройки открываются шестерёнкой (`ToolbarItem(placement: .topBarLeading)`) в `MainNavigationStack` как sheet
  с `AppSettingsNavigationStack` — единственным receiver `AppSettingsDestinations`;
- `___PACKAGENAME___/Navigation/Destinations/` — `@retroactive NavigationDestination` conformance;
- `___PACKAGENAME___/Navigation/Stacks/` — `ManagedNavigationStack(scene: RootTabs.<tab>.id)` per stack;
- bundle id: `___VARIABLE_bundleIdentifierPrefix:bundleIdentifier___.___PACKAGENAME___`;
- configurations: `Debug`, `AppStore`;
- packages: `App` (Main, Onboarding, Settings), `Services`, `Database`, `Models`, `Env`;
- model: `___VARIABLE_modelName___` (`Models`), entity `___VARIABLE_modelName___Entity` (`Database`, internal);
- storage: `___VARIABLE_modelName___StorageService` (`@ModelActor`);
- app services: `___VARIABLE_modelName___Service` (`___VARIABLE_modelPluralVariableName___`, `___VARIABLE_modelVariableName___(id:)`, `create`, `delete`);
- features: `Main` (список `___VARIABLE_modelName___`) → `___VARIABLE_modelName___Detail`; `AppSettings` (корень настроек) → `___VARIABLE_modelName___Settings`; `OnboardingGreeting` → `OnboardingSetup`;
- тесты: `DatabaseTests`, `ServicesTests`, `MainTests` (Swift Testing, in-memory store) и `___PACKAGENAME___UITests` (launch smoke); они не заменяют Manual QA.

## Известные backlog defects

- нет.

Не исправлять известный unrelated defect в рамках другой Issue без причины блокировки.
