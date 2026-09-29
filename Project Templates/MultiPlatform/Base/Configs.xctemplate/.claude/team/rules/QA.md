# Manual QA — iOS Simulator + Xcode MCP

QA проверяет feature как пользователь. Анализ кода не заменяет реальный simulator run.

## Environment

- simulator: iPhone 17e / iOS 27.0 (`IOS_DESTINATION` в makefile; runtime ниже iOS 27 не подходит к toolchain Xcode 27);
- iPad: iPad Air 11-inch (M4) / iOS 27.0;
- UDID получать через `make simulator-list`;
- bundle id: `___VARIABLE_bundleIdentifierPrefix:bundleIdentifier___.___PACKAGENAME___`;
- Xcode MCP server: `xcrun mcpbridge`;
- Xcode → Settings → Intelligence → Enable MCP server должен быть включён.

Не трогать другие запущенные simulator devices.

## Launch

`make run` собирает, устанавливает и запускает приложение.

Для конкретного device:

```bash
make run IOS_DESTINATION='id=<udid>'
```

Console diagnostics:

```bash
xcrun simctl spawn <udid> log stream
```

## Xcode MCP interaction

Каждый fresh QA agent открывает собственную DeviceInteraction session и обязательно закрывает её.
Session key нельзя передавать другой Claude-сессии.

Устройство используется монопольно: два QA runs одновременно не запускать.

Interaction:

- start: `DeviceInteractionStartSession`;
- actions: `DeviceInteractionSynthesize`;
- end: `DeviceInteractionEndSession`.

Рабочий command syntax:

- tap: `t <x> <y>`;
- swipe: `t <x1> <y1> f <x2> <y2> [duration]`;
- Home button: `b h`;
- text: `sender keyboard kbd <text>` — text input command должна быть последней в chain.

Команды `type` нет.

## Accessibility limitation

Issue #10: accessibility tree пустой. XCUITest и hierarchy dump не дают usable leaf elements.
Координаты брать со screenshot.

Screenshot возвращается в points 440×956 и соответствует tap coordinate system.

После action screenshot может быть снят до конца animation/input. Делать дополнительный вызов с пустым
`interactionCommand`, затем оценивать экран.

`applicationState` может возвращать `NotRun`, даже когда app работает — ориентироваться на screenshot.

## device-interaction skill

Project skill `device-interaction` отсутствует. Definition находится:

`/Users/admin/Developer/AppConnector/xcode-skills/device-interaction/SKILL.md`

Читать напрямую через Bash только если нужно составить корректный interaction command.

## What to test

- основной user flow;
- альтернативные сценарии;
- очевидные edge cases;
- regression areas из Issue/PR;
- empty/loading/error states, если применимы;
- persistence save/load и restart, если feature работает с данными.

Зелёный build и unit tests не являются PASS Manual QA.

## Report

Только то, что реально наблюдалось на экране.

Verdict:

- `PASS`; или
- `FAIL` + steps to reproduce, expected, actual, screenshot/log context; или
- `BLOCKED` + точная ошибка и шаги — тестирование физически невозможно по причинам среды
  (MCP session не открывается, simulator недоступен и т.п.), а не из-за поведения фичи.

`BLOCKED` ≠ `FAIL`: это не вердикт о качестве фичи. Team Lead решает — восстановить среду
или перевести Issue в `Hold`.

При невозможности использовать interaction tool вернуть Team Lead `BLOCKED` с точной ошибкой, а не подменять QA code review.

Ничего не устанавливать через brew/npm/gem для обхода ограничений.
