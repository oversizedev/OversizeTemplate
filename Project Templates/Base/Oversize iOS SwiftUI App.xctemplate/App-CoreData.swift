//___FILEHEADER___

import Factory
import OversizeKit
import OversizeServices
import OversizeUI

@main
struct ___PACKAGENAME:identifier___App: App {
    
    @Injected(\.appStateService) var appStateService: AppStateService
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject private var router = Router()
    @StateObject private var appSettingsViewModel = AppSettingsViewModel()
    var persistenceController = PersistenceController.shared
    let pub = NotificationCenter.default.publisher(for: NSNotification.Name("Deeplink"))
    
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
            .hud(router.hudText, isPresented: $router.isShowHud)
            .sheet(item: $router.sheet) { sheet in
               router.resolveSheet(sheet: sheet)
                   .hud(router.hudText, isPresented: $router.isShowHud)
                   .alert(item: $router.alert) { $0.alert }
                   .environmentObject(appSettingsViewModel)
                   .systemServices()
            }
            .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
               router.resolveSheet(sheet: fullScreenCover)
                   .hud(router.hudText, isPresented: $router.isShowHud)
                   .alert(item: $router.alert) { $0.alert }
                   .environmentObject(appSettingsViewModel)
                   .systemServices()
            }
            .alert(item: $router.alert) { $0.alert }
            .onOpenURL { router.handle($0) }
            .environmentObject(router)
            .environmentObject(appSettingsViewModel)
            .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
            .onReceive(pub) { output in
               if let userInfo = output.userInfo, let info = userInfo["link"] {
                   let url = URL(string: info as! String)!
                   router.handle(url)
               }
            }
        }
    }
}
