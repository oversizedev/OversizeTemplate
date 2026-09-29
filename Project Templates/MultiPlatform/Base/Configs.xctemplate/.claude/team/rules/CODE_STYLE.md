# Code style and communication

- Swift 6 / SwiftUI conventions.
- Async/Await и actors.
- Code identifiers и code-related artifacts — English.
- Chat, планы и отчёты Team Lead — Russian.
- Не писать comments в product code; только `// MARK: -` при необходимости, на English.
- Не использовать однобуквенные variable names.
- Использовать существующие patterns и components прежде чем вводить новые abstractions.
- Если есть Makefile, предпочитать `make <target>`; после code changes использовать `make compile`/`make build` по правилам проекта.
- Не устанавливать system dependencies без явного согласования.

## File header

3 строки, соответствующие существующей convention проекта:

- `Copyright © ___YEAR___ ___FULLUSERNAME___`
- `<FileName>.swift, created on DD.MM.YYYY`

## Git

- commit title максимум 100 символов;
- первая буква uppercase;
- без `feat:`, `fix:`, `chore:` и других conventional prefixes;
- для небольшого изменения suffix `#patch`;
- не добавлять `Co-Authored-By: Claude` / Anthropic trailer.
