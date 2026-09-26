# ___PACKAGENAME___ Agent Workflow v2 — Ephemeral Sessions

Этот workflow заменяет долгоживущую Agent Team на гибридную модель:

- GitHub Project + Issues = долговечная память и очередь;
- git/PR = долговечное состояние реализации;
- каждая Team Lead session = одна GitHub Issue;
- каждое обращение к роли = новая сессия агента;
- Agent Team создаётся только когда двум активным исполнителям действительно нужно общаться напрямую;
- после merge Team Lead завершает работу и НЕ берёт следующую Issue.

## Главный принцип

```
Claude session = disposable compute
GitHub         = persistent workflow state
Git            = persistent implementation state
```

`/compact`, `/clear`, resume старых workers и накопление истории между Issues не являются частью процесса.

## Файлы контекста

Никто больше не обязан читать один огромный общий файл. Читай только документы своей роли:

| Файл | Содержание |
|---|---|
| `.claude/team/WORKFLOW.md` | lifecycle и правила ephemeral sessions |
| `.claude/team/TEAM_LEAD.md` | orchestration одной Issue |
| `.claude/team/rules/GITHUB.md` | Project, Issues, ветки, PR, backlog |
| `.claude/team/rules/PROJECT.md` | фактическое состояние ___PACKAGENAME___ и build-инструменты |
| `.claude/team/rules/ARCHITECTURE.md` | архитектурные инварианты |
| `.claude/team/rules/QA.md` | simulator и Xcode MCP |
| `.claude/team/rules/CODE_STYLE.md` | код-стайл и коммуникация |

Источник истины о фактическом проекте — код и `rules/PROJECT.md`. При расхождении с `CLAUDE.md`
не следуй устаревшему описанию вслепую.

## Два уровня декомпозиции

### Persistent decomposition — GitHub

Большая пользовательская задача создаёт:

```
Epic
├── Issue A
├── Issue B (Depends-On: #A)
├── Issue C (Depends-On: #A)
└── Issue D (Depends-On: #B #C)
```

Каждая child Issue должна быть независимо реализуемой и mergeable. Она живёт дольше любой
Claude-сессии и может быть выполнена совершенно новым Team Lead.

### Local decomposition — Task List

Внутри одной Issue Team Lead может создать локальные Tasks: research, storage, UI, integration,
review findings, fixes, QA bugs. Они существуют только до завершения текущей Issue и не являются
межсессионной памятью.

## Размер задачи

### Small

Typo, локальный UI tweak, простой bug fix, небольшой refactor, одно очевидное поле.

- архитектор не нужен;
- один fresh developer subagent;
- затем fresh reviewers;
- QA только если изменение пользовательского поведения требует реального прогона.

### Medium

Одна feature или bounded change без необходимости долговременной декомпозиции на несколько PR.

- при необходимости fresh `solution-architect`;
- один или два fresh developers;
- если `feature-developer` и `storage-developer` должны согласовывать API в процессе — временная Agent Team из двух человек;
- после реализации team cleanup.

### Large

Целое приложение, крупная feature, несколько экранов/слоёв, новые Domain models / Storage services,
изменение navigation, несколько независимо mergeable частей или сложный dependency graph.

- отдельная planning session;
- fresh `solution-architect`;
- Epic + child Issues в GitHub;
- только unblocked child Issues получают `Ready`;
- каждая child Issue выполняется отдельной Team Lead session.

## Fresh worker policy — обязательное правило

Каждый новый вызов роли создаёт новый контекст.

Разрешено:

```
Agent(feature-developer) → закончил → session closed
Agent(code-reviewer)     → CHANGES REQUESTED → session closed
Agent(feature-developer) → новая session для фикса
Agent(code-reviewer)     → новая session для повторного review
```

Запрещено:

- resume старого subagent;
- `SendMessage` в остановленный subagent по agent ID;
- держать reviewer/QA/architect idle в ожидании исправлений;
- переиспользовать teammate после завершения его work package.

`SendMessage` допустим только между **одновременно активными** teammates временной Agent Team,
например `feature-developer ↔ storage-developer` во время согласования контракта.

## Выбор механизма исполнения

### One-shot subagent — default

Используй для:

- `solution-architect`;
- одного `feature-developer`;
- одного `storage-developer`;
- `architecture-reviewer`;
- `code-reviewer`;
- `manual-qa`;
- developer fix после review/QA.

Каждый вызов — новая `Agent` invocation. Не resume.

### Agent Team — только реальная peer-to-peer координация

Создавай временную Agent Team только если одновременно нужны минимум два исполнителя и им требуется
прямое общение. Основной кейс проекта:

```
Team Lead
├── feature-developer
└── storage-developer
```

После завершения work package:

1. оба teammate отчитываются;
2. Team Lead просит обоих завершить session;
3. Team Lead выполняет team cleanup;
4. эта команда больше никогда не переиспользуется.

Не создавать team для architect → developer → reviewer → QA: это последовательные стадии.

## Pipeline одной executable Issue

```
Ready
  ↓
NEW Team Lead session
  ↓
In Progress
  ↓
Fresh implementation worker(s)
  ↓
Build
  ↓
Ready for Review → In Review
  ↓
Fresh Architecture Reviewer ─┐
Fresh Code Reviewer          ├─ оба PASS
                             ┘
  ↓
Ready for Testing → Testing
  ↓
Fresh Manual QA
  ↓
Merge
  ↓
Issue closed + Done
  ↓
Team Lead session exits
```

При любом замечании:

```
In Progress
→ NEW developer session
→ Build
→ NEW Architecture Reviewer
→ NEW Code Reviewer
→ NEW Manual QA
```

После существенного исправления старые PASS недействительны.

## Внешний блокер → Hold

Fix-циклы применимы только к дефектам кода. Если на любом этапе задача упирается во
**внешний** блокер (upstream-зависимость, недоступный сервис, сломанная тестовая среда),
Issue уходит в `Hold`, а не крутится в `In Progress`:

```
любой этап
→ внешний блокер
→ комментарий `Blocked: <причина>` в Issue
→ ветка запушена, PR в draft
→ Project status = Hold
→ Team Lead session завершается
→ orchestrator берёт следующую Ready Issue
```

Если блокер затрагивает только часть scope — заблокированный остаток выносится в отдельную
Issue сразу в `Hold`, а сделанная и протестированная часть доводится до merge обычным pipeline.
Правила и процедура — `rules/GITHUB.md`, раздел «Hold».

Возврат из `Hold` в `Ready` — ручное решение человека после устранения блокера.

## Quality gates

Базовый полный pipeline:

```
Implementation → Build → Architecture Review → Code Review → Manual QA → Merge
```

QA можно пропустить только если Team Lead может явно обосновать, что изменение не затрагивает
пользовательское поведение и реальный simulator flow ничего не проверит (например чистый внутренний
refactor). Для feature/bug в UI QA обязателен.

## Ограничение параллелизма

Нормальный максимум активных coding workers — 2.

- один независимый worker → один subagent;
- feature + storage с общим контрактом → два teammates;
- reviewers допускается запускать параллельно после зелёной сборки;
- не держать 4+ активных Claude sessions без реальной независимой работы.

## Контекст между сессиями

Новая сессия получает только:

- текущую GitHub Issue;
- parent Epic при наличии;
- явно указанные dependency Issues при необходимости;
- актуальный git/branch/diff;
- релевантные rule-файлы;
- конкретные review/QA findings при fix-итерации.

Не передавать историю предыдущего агента, длинные transcript summaries или старые tool results.
