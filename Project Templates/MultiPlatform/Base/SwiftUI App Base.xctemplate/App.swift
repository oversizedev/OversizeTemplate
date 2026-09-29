//___FILEHEADER___

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
                RootView()
            }
            .onboarding {
                OnboardingNavigationStack()
            }
            .navigationBarAppearanceConfiguration()
        }
    }
}
