# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Development Commands

### Primary Commands (Makefile)
```bash
make init          # Initialize project with local dependencies (run once after clone)
make build         # Format, generate code, build with local packages
make build-prod    # Build for production with remote packages
make test          # Run tests in iOS Simulator (iPhone 16e, iOS 26.0)
make run           # Build and run in simulator
make format        # Format code with SwiftFormat
make gen           # Generate code from OpenAPI specs and SwiftGen
make clean         # Clean DerivedData
make reload        # Quit and reopen Xcode
```

### Local vs Remote Development
- **Local development**: Uses `make build` with packages from `~/Developer/Packages`
- **Production/CI**: Uses `make build-prod` with remote package dependencies
- Dependency mode is **resolved automatically** via `FileManager.default.fileExists` in each `Package.swift` — no manual switching needed

### Testing
- Tests run on iOS Simulator: iPhone 16e, iOS 26.0
- Scheme: "___PACKAGENAME___ (Dev)"
- Command: `make test`

## Architecture Overview

### Modular Structure (Swift Package Manager)
Three core local modules in `Packages/`:

1. **App** - Business logic and features
   - `Main/` - Primary app functionality
   - `Onboarding/` - Onboarding flow

2. **Database** - Data persistence layer
   - `Models/` - SwiftData models
   - `Services/` - Actor-based storage services
   - `Injection/` - Dependency injection setup

3. **Env** - Shared environment types
   - `Destinations/` - Navigation destination enums
   - `Root/` - Root screen type definitions

### Navigation Architecture
**Adaptive UI pattern** based on device:
- **iPhone**: TabView (`RootTabView.swift`)
- **iPad**: SplitView with sidebar (`RootSplitView.swift`)
- Root coordinator: `RootView.swift` switches between layouts

**Navigation flow**:
1. `___PACKAGENAME___App.swift` - Entry point with Launcher
2. `ResolveRoot.swift` - Resolves onboarding vs main app
3. `ResolveTabs.swift` - Resolves tab structure
4. Destination enums:
   - `OnboardingDestinations.swift` - Onboarding routes
   - `MainDestinations.swift` - Main app routes

### Dependency Injection (Factory Kit)
```swift
@Injected(\.storageService) var storage
```

Container setup in `Database/Injection/`

### Data Layer (SwiftData)
- **Models**: Use SwiftData with `@Model` macro
- **Services**: Actor-based for thread safety
- **External storage**: Use `@Attribute(.externalStorage)` for images

### MVVM + Module Pattern
- **@Module macro** from OversizeArchitecture for feature modules
- **ViewStateProtocol** pattern for state management
- **Async/Await** throughout (Swift 6 strict concurrency enabled)
- **Actors** for shared mutable state

## Code Guidelines

### Swift 6 Concurrency
- Full strict concurrency checking enabled
- Use actors for services accessing shared state
- Prefer async/await over callbacks
- Mark @MainActor for UI-bound types

### File Organization
- **New views**: Create in `Subviews/` folder within feature module
- **Previews**: Always include #Preview for SwiftUI views
- **Marks**: Use `// MARK: -` for section organization (English)
- **Comments**: Avoid unless necessary (code should be self-documenting)

### Module Pattern
```swift
@Module
public enum FeatureName: ModuleProtocol {}

@View(module: FeatureName.self)
public struct FeatureView: ViewProtocol {
    public var body: some View { ... }
}

@ViewModel(module: FeatureName.self)
public actor FeatureViewModel: ViewModelProtocol { ... }

@Observable
public final class FeatureViewState: ViewStateProtocol {
    public init(input _: FeatureName.Input?) {}
}
```

### Navigation Pattern
```swift
enum FeatureDestinations: ScreenDestination {
    case detail(id: String)
    case settings
}

@Navigator(FeatureDestinations.self) var navigator
```

## Key Files

### Entry Points
- `___PACKAGENAME___/App/___PACKAGENAME___App.swift` - Main app entry
- `___PACKAGENAME___/Root/RootView.swift` - Root coordinator
- `___PACKAGENAME___/Navigation/ResolveRoot.swift` - Root resolution logic

### Configuration
- `Configs/Base.yml` - XcodeGen base config
- `Configs/Packages.yml` - Remote dependencies
- `Configs/PackagesLocal.yml` - Local dependencies
- `Configs/Targets.yml` - Target configurations
- `Configs/Settings.yml` - Build settings

## Build Configurations

Three build configurations:
1. **Debug (Dev)**
   - Bundle ID: `<bundle-id>.dev`
   - Product Name: "___PACKAGENAME___ Dev"
   - App Icon: AppIcon(Dev)

2. **TestFlight**
   - Bundle ID: `<bundle-id>`
   - Product Name: "___PACKAGENAME___ TestFlight"
   - Compilation condition: TESTFLIGHT

3. **AppStore**
   - Bundle ID: `<bundle-id>`
   - Product Name: "___PACKAGENAME___"
   - Compilation condition: APPSTORE

## Dependencies

### Oversize Framework Ecosystem
- OversizeUI (3.0.2) - UI components
- OversizeArchitecture (0.2.0) - @Module macro, architectural patterns
- OversizeNavigation (0.3.0) - Navigator patterns
- OversizeServices (1.4.0) - Common services
- OversizeComponents (2.0.0) - Reusable components
- OversizeLocalizable (1.5.0) - Localization
- OversizeResources (2.0.0) - Asset management

### Third-party
- Factory (2.1.3) - Dependency injection
- Navigator (1.1.1) - Navigation management
- ObservableDefaults (1.6.0) - UserDefaults wrapper

## Project Setup

### Initial Setup
```bash
make init  # Clones local packages, generates code, builds project
```

This runs scripts to:
1. Clone Oversize packages to `~/Developer/Packages`
2. Generate OpenAPI code
3. Run SwiftGen for resources
4. Build project with local packages
5. Reload Xcode

### Code Quality Tools
- **SwiftFormat**: Auto-formats code in both Packages and Project
- **SwiftLint**: Opt-in rules enabled
- **XcodeGen**: Project generation from YAML configs

## Development Workflow

1. **Feature development**: Work in local packages (`~/Developer/Packages`)
2. **Format regularly**: `make format` before commits
3. **Generate code**: `make gen` after OpenAPI/resource changes
4. **Build**: `make build` for local development
5. **Test**: `make test` before PR
6. **Production build**: `make build-prod` for releases
