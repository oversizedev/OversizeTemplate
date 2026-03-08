# Create Swift files in Env package
rm -rf Packages/Env/Sources/Env/Env.swift

# Env Root folder
mkdir -p Packages/Env/Sources/Env/Root
cat <<'SWIFT_EOF' > Packages/Env/Sources/Env/Root/RootType.swift
public enum RootType: Int {
    case tabbed
    case split
}

public struct ToogleAppRootType: Hashable {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/Env/Sources/Env/Root/RootTabs.swift
import OversizeResources
import OversizeUI
import SwiftUI

public nonisolated enum RootTabs: Int, Codable {
    case main
    case settings
}

extension RootTabs: Identifiable {
    public static var tabs: [RootTabs] {
        [.main, .settings]
    }

    public static var sidebar: [RootTabs] {
        [.main, .settings]
    }

    public var icon: Image {
        switch self {
        case .main:
            Image.Base.Home.fill
        case .settings:
            Image.Base.Setting.fill
        }
    }

    public var title: String {
        switch self {
        case .main:
            .init("Main")
        case .settings:
            .init("Settings")
        }
    }

    public var id: String {
        "\(self)"
    }
}
SWIFT_EOF

# Env Destinations folder
mkdir -p Packages/Env/Sources/Env/Destinations
cat <<'SWIFT_EOF' > Packages/Env/Sources/Env/Destinations/MainDestinations.swift
import SwiftUI

public nonisolated enum MainDestinations: CaseIterable {
    case detail
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/Env/Sources/Env/Destinations/OnboardingDestinations.swift
import SwiftUI

public nonisolated enum OnboardingDestinations: CaseIterable {
    case setup
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/Env/Sources/Env/Destinations/SettingsDestinations.swift
import SwiftUI

public nonisolated enum AppSettingsDestinations: CaseIterable {
    case appSettings
}
SWIFT_EOF

# App - remove default generated source
rm -rf Packages/App/Sources/App

# App - Main module
mkdir -p Packages/App/Sources/Main/Main
cat <<'SWIFT_EOF' > Packages/App/Sources/Main/Main/MainModule.swift
import OversizeArchitecture

@Module
public enum Main: ModuleProtocol {}

public struct MainInput: Sendable {}

public struct MainOutput: Sendable {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Main/Main/MainView.swift
import OversizeArchitecture
import OversizeKit
import OversizeNavigation
import OversizeNoticeKit
import OversizeUI
import SwiftUI

@View(module: Main.self)
public struct MainView: ViewProtocol {
    public var body: some View {
        NavigationLayoutView("Main") {
            content
        } background: {
            Color.backgroundSecondary
        }
        .contentMargins()
        .toolbarTitleDisplayMode(.inline)
        .navigationMove($viewState.destination)
        .toolbar(content: { toolbarContent })
    }

    var content: some View {
        VStack(spacing: .small) {
            NoticeListView()

            AdView()
        }
        .surfaceRadius(.medium)
    }
}

private extension MainView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button("Detail") {
                reducer.callAsFunction(.onTapDetail)
            }
            .labelStyle(.toolbar)
            .buttonStyle(.toolbarPrimary)
            .keyboardShortcut(.defaultAction)
        }
    }
}

#Preview {
    NavigationStack {
        Main.build()
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Main/Main/MainViewModel.swift
import OversizeArchitecture

@ViewModel(module: Main.self)
public actor MainViewModel: ViewModelProtocol {
    func onTapDetail() async {
        await state.update {
            $0.destination = .detail
        }
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Main/Main/MainViewState.swift
import Env
import Observation
import OversizeArchitecture
import SwiftUI

@Observable
public final class MainViewState: ViewStateProtocol {
    public var destination: MainDestinations?

    public init(input _: Main.Input?) {}
}
SWIFT_EOF

# App - Onboarding/OnboardingGreeting module
mkdir -p Packages/App/Sources/Onboarding/OnboardingGreeting
cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingGreeting/OnboardingGreeting.swift
import OversizeArchitecture

@Module
public enum OnboardingGreeting: ModuleProtocol {}

public struct OnboardingGreetingInput: Sendable {}

public struct OnboardingGreetingOutput: Sendable {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingGreeting/OnboardingGreetingView.swift
import OversizeArchitecture
import OversizeNavigation
import OversizeOnboardingKit
import OversizeServices
import OversizeUI
import SwiftUI

@View(module: OnboardingGreeting.self)
public struct OnboardingGreetingView: ViewProtocol {
    public var body: some View {
        OnboardView(
            content: {
                content
            },
            actions: {
                actions
            }
        )
        .navigationMove($viewState.destination)
    }

    var content: some View {
        VStack(spacing: .large) {
            Spacer()

            if let image = Info.App.icon {
                image
                    .resizable()
                    .frame(width: 96, height: 96)
                    .mask(RoundedRectangle(
                        cornerRadius: 22,
                        style: .continuous
                    ))
            } else {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.gray)
                    .frame(width: 96, height: 96)
            }

            VStack(spacing: .small) {
                Text("Welcome")
                    .largeTitle()

                Text("All your information in one app")
                    .title2(.semibold)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .large)
            }

            Spacer()
        }
    }

    var actions: some View {
        Button("Get Started") {
            reducer.callAsFunction(.onTapContinue)
        }
        .buttonStyle(.primary)
        .controlSize(.large)
        .accent()
    }
}

#Preview {
    NavigationStack {
        OnboardingGreeting.build()
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingGreeting/OnboardingGreetingViewModel.swift
import FactoryKit
import OversizeArchitecture
import OversizeServices

@ViewModel(module: OnboardingGreeting.self)
public actor OnboardingGreetingViewModel: ViewModelProtocol {
    func onTapContinue() async {
        await state.update {
            $0.destination = .setup
        }
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingGreeting/OnboardingGreetingViewState.swift
import Env
import Observation
import OversizeArchitecture
import SwiftUI

@Observable
public final class OnboardingGreetingViewState: ViewStateProtocol {
    public var destination: OnboardingDestinations?

    public init(input _: OnboardingGreeting.Input?) {}
}
SWIFT_EOF

# App - Onboarding/OnboardingSetup module
mkdir -p Packages/App/Sources/Onboarding/OnboardingSetup
cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingSetup/OnboardingSetup.swift
import OversizeArchitecture

@Module
public enum OnboardingSetup: ModuleProtocol {}

public struct OnboardingSetupInput: Sendable {}

public struct OnboardingSetupOutput: Sendable {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingSetup/OnboardingSetupView.swift
import OversizeArchitecture
import OversizeNavigation
import OversizeOnboardingKit
import OversizeUI
import SwiftUI

@View(module: OnboardingSetup.self)
public struct OnboardingSetupView: ViewProtocol {
    @FocusState private var focusedField: OnboardingSetupViewState.FocusField?

    public var body: some View {
        OnboardView(
            content: {
                content
            },
            actions: {
                actions
            }
        )
        .onAppear { focusedField = .firstText }
    }

    var content: some View {
        ScrollView {
            VStack(spacing: .large) {
                VStack(spacing: .xSmall) {
                    Text("Setup")
                        .title2()

                    Text("Enter your basic settings")
                        .body(.semibold)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, .large)
                }

                VStack(spacing: .small) {
                    firstTextField

                    secondTextField
                }
                .fieldLabelPosition(.overInput)
            }
        }
        .contentMargins()
    }

    private var firstTextField: some View {
        TextField("First text", text: $viewState.firstText)
            .textFieldStyle(.placeholder("First text", text: $viewState.firstText))
            .submitLabel(.next)
            .onSubmit { focusedField = .secondText }
            .focused($focusedField, equals: .firstText)
            .onChangeValue(of: viewState.firstText) {
                reducer.callAsFunction(.onChangeFirstText($0))
            }
    }

    private var secondTextField: some View {
        TextField("Second text", text: $viewState.secondText)
            .textFieldStyle(.placeholder("Second text", text: $viewState.secondText))
            .submitLabel(.continue)
            .onSubmit { reducer.callAsFunction(.onTapSecondTextContinue) }
            .focused($focusedField, equals: .secondText)
            .onChangeValue(of: viewState.secondText) {
                reducer.callAsFunction(.onChangeSecondText($0))
            }
    }

    var actions: some View {
        Button("Continue") {
            reducer.callAsFunction(.onTapBottomContinue)
        }
        .buttonStyle(.primary)
        .controlSize(.large)
        .accent()
    }
}

#Preview {
    NavigationStack {
        OnboardingSetup.build()
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingSetup/OnboardingSetupViewModel.swift
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeServices

@ViewModel(module: OnboardingSetup.self)
public actor OnboardingSetupViewModel: ViewModelProtocol {
    @Injected(\.appStateService) var appStateService: AppStateService

    func onFocusField(_ field: OnboardingSetupViewState.FocusField?) async {
        await state.update { $0.focusedField = field }
    }

    func onTapSecondTextContinue() async {
        await completeOnboarding()
    }

    func onTapBottomContinue() async {
        await completeOnboarding()
    }

    func onChangeFirstText(_: String) async {
        await updateFormValidation()
    }

    func onChangeSecondText(_: String) async {
        await updateFormValidation()
    }
}

private extension OnboardingSetupViewModel {
    func updateFormValidation() async {
        logDebug("Form validation")
    }

    func completeOnboarding() async {
        appStateService.completedOnboarding()
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Onboarding/OnboardingSetup/OnboardingSetupViewState.swift
import Env
import Observation
import OversizeArchitecture
import OversizeNavigation
import SwiftUI

@Observable
public final class OnboardingSetupViewState: ViewStateProtocol {
    public var firstText: String = ""
    public var secondText: String = ""

    public var focusedField: FocusField?
    public var hud: HUD?

    public init(input _: OnboardingSetup.Input?) {}
}

// MARK: - Supporting types

public extension OnboardingSetupViewState {
    enum FocusField: String, Hashable, Sendable {
        case firstText, secondText
    }
}
SWIFT_EOF

# App - Settings module
mkdir -p Packages/App/Sources/Settings/AppSettings
cat <<'SWIFT_EOF' > Packages/App/Sources/Settings/AppSettings/AppSettings.swift
import OversizeArchitecture

@Module
public enum AppSettings: ModuleProtocol {}

public struct AppSettingsInput: Sendable {}

public struct AppSettingsOutput: Sendable {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Settings/AppSettings/AppSettingsView.swift
import OversizeArchitecture
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: AppSettings.self)
public struct AppSettingsView: ViewProtocol {
    public var body: some View {
        NavigationLayoutView("App settings") {
            content
        } background: {
            Color.backgroundSecondary
        }
        .toolbarTitleDisplayMode(.inline)
    }

    var content: some View {
        LeadingVStack {
            SectionView {
                Row("App settings") {} leading: {
                    Image.Base.edit.icon()
                }
            }
        }
        .sectionContentCompactRowMargins()
    }
}

#Preview {
    NavigationStack {
        AppSettings.build()
    }
}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Settings/AppSettings/AppSettingsViewModel.swift
import OversizeArchitecture

@ViewModel(module: AppSettings.self)
public actor AppSettingsViewModel: ViewModelProtocol {}
SWIFT_EOF

cat <<'SWIFT_EOF' > Packages/App/Sources/Settings/AppSettings/AppSettingsViewState.swift
import Observation
import OversizeArchitecture
import SwiftUI

@Observable
public final class AppSettingsViewState: ViewStateProtocol {
    public init(input _: AppSettings.Input?) {}
}
SWIFT_EOF

# App - Test directories
mkdir -p Packages/App/Tests/MainTests
mkdir -p Packages/App/Tests/OnboardingTests
mkdir -p Packages/App/Tests/SettingsTests

cat > Packages/App/Tests/MainTests/MainTests.swift << 'SWIFT_EOF'
@testable import Main
import XCTest

final class MainTests: XCTestCase {
    func testExample() {
        // Test placeholder
    }
}
SWIFT_EOF

cat > Packages/App/Tests/OnboardingTests/OnboardingTests.swift << 'SWIFT_EOF'
@testable import Onboarding
import XCTest

final class OnboardingTests: XCTestCase {
    func testExample() {
        // Test placeholder
    }
}
SWIFT_EOF

cat > Packages/App/Tests/SettingsTests/SettingsTests.swift << 'SWIFT_EOF'
@testable import Settings
import XCTest

final class SettingsTests: XCTestCase {
    func testExample() {
        // Test placeholder
    }
}
SWIFT_EOF
