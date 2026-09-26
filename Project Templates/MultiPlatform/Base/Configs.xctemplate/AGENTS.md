# Repository Guidelines

`CLAUDE.md` is the single source of truth for architecture, commands, tests and conventions. Read it first;
this file only lists what every agent must follow.

## Core Instructions
- Swift 6 and SwiftUI conventions, strict concurrency, async/await and actors.
- No code comments; only `// MARK: -` sections in English when needed.
- Code identifiers and in-code text in English; chat with the user in Russian.
- Never modify `$HOME/Developer/Packages`: those packages are shared between projects.
- Use `make` targets for build, test, lint and run.

## Completion Checklist
- `make build` (includes `make arch-check`).
- `make test`.
- If `Packages/` changed: `make init-scripts` and `make verify-init`.
- Run the app with `make run` for UI changes.
