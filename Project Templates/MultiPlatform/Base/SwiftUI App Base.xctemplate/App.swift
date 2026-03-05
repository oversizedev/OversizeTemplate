//___FILEHEADER___

import SwiftUI
import FactoryKit
import OversizeServices
import NavigatorUI
import TipKit

@main
struct ___PACKAGENAME:identifier___App: App {
    @Injected(\.appStateService) var appStateService: AppStateService
    
    init() {
        try? Tips.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ApplicationRootView()
                .navigationBarAppearanceConfiguration()
                .appLaunch {
                    VStack {
                        Text("Welcome")
                        Button("Complete") {
                            appStateService.completedOnboarding()
                        }
                    }
                }
        }
    }
}

struct ApplicationRootView: View {
    @SceneStorage("appRootType") var appRootType: AppRootType = UIDevice.current.userInterfaceIdiom == .pad ? .split : .tabbed

    var body: some View {
        appRootType
            .onNavigationOpenURL()
            .onNavigationReceive { (_: ToogleAppRootType) in
                appRootType = appRootType == .split ? .tabbed : .split
                return .auto
            }
    }

    func applicationNavigator() -> Navigator {
        let configuration: NavigationConfiguration = .init(
            restorationKey: nil,
            executionDelay: 0.3,
            verbosity: .info
        )
        return Navigator(configuration: configuration)
    }
}

enum AppRootType: Int {
    case tabbed
    case split
}

extension AppRootType: NavigationDestination {
    var body: some View {
        switch self {
        case .tabbed:
            RootTabView()
        case .split:
            RootSplitView()
        }
    }
}

struct ToogleAppRootType: Hashable {}
