//___FILEHEADER___

import Factory
import OversizeKit
import OversizeServices
import OversizeUI
import SwiftUI
import TipKit

@main
struct ___PACKAGENAME:identifier___App: App {
    @Injected(\.appStateService) var appStateService: AppStateService

    init() {
        try? Tips.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .appLaunch {
                    Text("Welcome")
                }
        }
    }
}
