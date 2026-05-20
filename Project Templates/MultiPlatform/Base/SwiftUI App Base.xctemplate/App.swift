//___FILEHEADER___

import FactoryKit
import Main
import NavigatorUI
import Onboarding
import OversizeKit
import OversizeNavigation
import SwiftUI
import TipKit

@main
struct ___PACKAGENAME:identifier___App: App {
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
        }
    }
}
