# Repository Guidelines

## Core Instructions
- Use Swift 6 and SwiftUI conventions.
- Prefer Async/Await and actors.
- Follow Swift 6 best practices and strict concurrency expectations.
- Do not write code comments unless necessary; if needed, only use `// MARK:` sections in English.
- Keep code identifiers and in-code text in English.
- Use Russian for chat communication with the user.

## Project Structure & Module Organization
The app source lives in `___PACKAGENAME___/` with feature areas split into `App/`, `Navigation/`, `Root/`, and shared assets in `Resources/`. Tests are in `___PACKAGENAME___Tests/` (unit/integration) and `___PACKAGENAME___UITests/` (UI). Build configuration and generation live in `project.yml`, `project_local.yml`, `Configs/`, and `scripts/`. External packages are managed under `Packages/` and generated files are produced by SwiftGen/OpenAPI tooling.

## Build, Test, and Development Commands
Use the Makefile targets for common tasks:
- `make build`: formats code, runs generators, and builds the project.
- `make build-prod`: formats, generates, and builds with production dependencies.
- `make format`: runs `swiftformat` on `Packages/` and the project.
- `make gen`: runs OpenAPI codegen and SwiftGen.
- `make test`: runs XCTest in the iOS Simulator.
- `make run`: builds and launches the Dev scheme in the Simulator.
- `make compile`: compiles without reformatting or code generation.
- `make clean`: clears Xcode DerivedData for this project.
- `make up-build`: increments build number (CURRENT_PROJECT_VERSION) and recompiles.
- `make up-version`: bumps MARKETING_VERSION (patch/minor/major, default: minor) and recompiles.

Dependency mode is resolved automatically in `Package.swift` files via `FileManager.default.fileExists`; no manual local/remote switching is required.

## Coding Style & Naming Conventions
Use Swift API Design Guidelines and let `swiftformat` enforce whitespace and layout. Names should be UpperCamelCase for types and lowerCamelCase for functions and properties. Keep view files focused; place new views in `___PACKAGENAME___/.../Subviews/` and include a SwiftUI preview.

## Testing Guidelines
Tests use XCTest. Place unit tests in `___PACKAGENAME___Tests/` and UI tests in `___PACKAGENAME___UITests/`. Test classes should end with `Tests`, and methods should start with `test` (e.g., `testLoadingState`). Run tests with `make test`.

## Commit & Pull Request Guidelines
Keep commit messages short and imperative (e.g., "Fix onboarding flow"). PRs should include a clear description, testing notes, and screenshots or screen recordings for UI changes. Link relevant issues when applicable.

## Automation & Tooling
Project generation uses XcodeGen (`project.yml` / `project_local.yml`). Resource code is generated with SwiftGen, and network models via the OpenAPI plugin in `Packages/OversizeNetwork`.

## Completion Checklist
After finishing changes:
- Build the project.
- Run the app in simulator if available.
- Run tests if available.

## Additional Guidance
- Use `CLAUDE.md` as the main additional repository guidance document.
