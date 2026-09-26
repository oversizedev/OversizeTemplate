# GitHub workflow — persistent queue

## Project

Проект: **___PACKAGENAME___ Development**, номер задаётся `PROJECT_NUMBER` в `.claude/team/orchestrator/config.sh`, owner `oversizedev`.

> ⚠️ GitHub Project для ___PACKAGENAME___ ещё не создан. После создания заполнить id ниже
> (`gh project field-list <N> --owner oversizedev --format json`).

- Project id: `<TBD>`
- Status field id: `<TBD>`

| Status | option id |
|---|---|
| Backlog | `<TBD>` |
| Ready | `<TBD>` |
| In Progress | `<TBD>` |
| Ready for Review | `<TBD>` |
| In Review | `<TBD>` |
| Ready for Testing | `<TBD>` |
| Testing | `<TBD>` |
| Done | `<TBD>` |
| Hold | `<TBD>` |

Любой failed gate из-за дефекта кода возвращает Issue в `In Progress`.
Невозможность продолжить из-за внешнего блокера переводит Issue в `Hold` (см. раздел «Hold»).

## Automation labels

Orchestrator использует фиксированные labels:

- `agent:auto` — Issue разрешено исполнять автоматически;
- `agent:task` — executable child Issue;
- `agent:epic` — parent Epic, сам не исполняется как coding Issue.

Не удалять эти labels у активной автоматизированной очереди.

## Large task → Epic + child Issues

Parent Epic содержит high-level Goal, Scope, Acceptance Criteria и checklist child Issues.

Каждая executable child Issue обязана иметь:

- `agent:auto`;
- `agent:task`;
- структуру `Goal / Context / Requirements / Acceptance Criteria / Technical Notes`;
- automation metadata отдельными строками:

```
Epic: #123
Depends-On: none
```

или:

```
Epic: #123
Depends-On: #124 #125
```

`Depends-On` — единственный формат зависимостей, который читает внешний orchestrator.

### Статусы при создании

- dependency list пуст → `Ready`;
- есть незакрытые dependencies → `Backlog`;
- Epic → `In Progress` пока не завершены все child Issues.

## Hold — внешние блокеры

`Hold` — только для **внешних** блокеров, которые команда не может устранить внутри Issue:

- внешняя зависимость вне репозитория (upstream-фикс, сторонний пакет, недоступный сервис);
- невозможность протестировать из-за среды (simulator/Xcode MCP сломаны, устройство недоступно).

Внутренние зависимости между Issues — это `Backlog` + `Depends-On`, не `Hold`.

Перевод в `Hold` выполняет Team Lead:

1. комментарий в Issue строкой `Blocked: <причина>` + что требуется для разблокировки;
2. ветка запушена, PR (если создан) переведён в draft с комментарием о блокере;
3. Project status = `Hold`;
4. session завершается; orchestrator берёт следующую `Ready` Issue.

Возврат из `Hold` — только вручную: после устранения блокера человек комментирует
`Unblocked: <что изменилось>` и переводит Issue в `Ready`. Orchestrator `Hold` не промоутит.

### Частичная блокировка

Если блокер затрагивает только часть scope, а остальное завершено и проходит gates:

1. заблокированный остаток выделяется в **отдельную** executable Issue по обычным правилам
   (`agent:auto` + `agent:task`, структура Goal/Context/..., ссылка на исходную Issue/PR в Context);
2. новая Issue сразу получает `Hold` и комментарий `Blocked: <причина>`;
3. исходная Issue сужается до сделанной части (комментарий: что и куда вынесено)
   и идёт через полный pipeline до merge/Done.

В merge попадает только сделанное и протестированное — без заглушек заблокированной части.

Child Issues должны быть независимо mergeable. Не дробить на бессмысленные технические микрошаги,
которые не могут существовать отдельным PR.

## Маленькая пользовательская задача

Можно создать одну executable Issue с `agent:auto` + `agent:task`, `Depends-On: none` и `Ready`.
Parent Epic не обязателен.

## Branch и PR

Branch:

```
feature/<issue>-<slug>
```

PR содержит:

- Summary
- Implementation
- Architecture
- UI
- Testing
- Risks / Regression Areas
- Issue

PR должен быть связан с Issue.

## Commit messages

- максимум 100 символов;
- начинать с большой буквы;
- без `feat:`, `fix:`, `chore:` и подобных conventional prefixes;
- для небольшого изменения в конце названия добавлять `#patch`;
- не добавлять `Co-Authored-By: Claude` или Anthropic trailers.

Для публичного PR описание короткое: 2–3 предложения, если нет причины писать больше.

## PR comments

Автоматический reviewer: `chatgpt-codex-connector[bot]`.

Проверять:

- после push, меняющего код;
- обязательно перед merge.

Не делать `sleep → check PR` polling loop.

Получить comments:

```bash
gh api repos/oversizedev/___PACKAGENAME___/pulls/<N>/comments -q '.[] | {path, line, body, created_at}'
```

Старые comments могут относиться к уже изменённому коду — учитывать `created_at` и актуальный diff.

Вердикт по comment:

- уже исправлено;
- актуально, блокирует merge;
- актуально, не блокирует — отдельная Issue;
- false positive с конкретным обоснованием.

## Побочные находки

Независимая проблема → отдельная Issue в Backlog/Ready, не исправлять в текущем PR.
В Issue записать reproduction, location и уже исключённые причины, если они проверялись.

Исключение: finding блокирует текущую задачу.

## Push

Remote прописан по SSH, но SSH-ключа нет. Push/PR выполняются через HTTPS с токеном `gh`.

## Orchestrator ownership

Внешний orchestrator:

- выбирает только open `agent:auto` + `agent:task` со статусом `Ready`;
- после завершения Issue вычисляет dependencies и переводит разблокированные Issues из `Backlog` в `Ready`;
- пропускает Issues в `Hold` и никогда не промоутит их автоматически;
- запускает каждую Issue новой Team Lead session;
- если Team Lead завершился, а Issue переведена в `Hold`, — берёт следующую `Ready` Issue;
- закрывает parent Epic, когда все его child Issues закрыты;
- если Ready-задач нет и все оставшиеся open auto tasks в `Hold` — завершается успешно
  с отчётом по Hold-задачам и их блокерам;
- останавливается с ошибкой, если есть open auto tasks вне `Hold`, но ни одна не `Ready`
  (blocked/cycle/manual intervention).
