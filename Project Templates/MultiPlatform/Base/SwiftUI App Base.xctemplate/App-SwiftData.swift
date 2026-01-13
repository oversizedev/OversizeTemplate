//___FILEHEADER___

import Database
import FactoryKit
import OversizeKit
import OversizeServices
import SwiftData
import SwiftUI
import TipKit

// Native

@main
struct ___PACKAGENAME:identifier___App: App {
    
    @Injected(\.appStateService) var appStateService: AppStateService
    @Injected(\.modelContainerService) private var sharedModelContainer

    var body: some Scene {
        WindowGroup {
            RootView()
                .appLaunch {
                    Text("Welcome")
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
