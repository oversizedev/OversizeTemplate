//___FILEHEADER___

import Database
import FactoryKit
import Main
import NavigatorUI
import Onboarding
import OversizeKit
import OversizeNavigation
import SwiftData
import SwiftUI
import TipKit

@main
struct ___PACKAGENAME:identifier___App: App {
    @Injected(\.modelContainerService) private var sharedModelContainer

    init() {
        try? Tips.configure()
    }

    var body: some Scene {
        WindowGroup {
            Launcher {
                MainNavigationStack()
            }
            .onboarding {
                OnboardingNavigationStack()
            }
            .navigationBarAppearanceConfiguration()
            .modelContainer(sharedModelContainer)
        }
    }
}
