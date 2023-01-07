//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeKit
import OversizeServices
import SwiftUI

@main
struct ___PACKAGENAME:identifier___App: App {
    
    @Injected(Container.appStateService) var appStateService: AppStateService
    @ObservedObject private var router = Router()
    @StateObject private var appSettingsViewModel = AppSettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                MainView()
                    .navigationDestination(for: Route.self) { destination in
                        router.resolve(pathItem: destination)
                    }
            }
            .appLaunch {
                OnboardingView()
            }
           .sheet(item: $router.sheet) { sheet in
               router.resolveSheet(sheet: sheet)
                   .environmentObject(appSettingsViewModel)
           }
           .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
               router.resolveSheet(sheet: fullScreenCover)
                   .environmentObject(appSettingsViewModel)
           }
           .environmentObject(router)
           .environmentObject(appSettingsViewModel)
           .environment(\.managedObjectContext, CoreDataHelper.shared.persistentContainer.viewContext)
        }
    }
}
