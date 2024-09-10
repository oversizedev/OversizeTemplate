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
    @ObservedObject private var router = Router()
    @StateObject private var appSettingsViewModel = AppSettingsViewModel()
    let pub = NotificationCenter.default.publisher(for: NSNotification.Name("Deeplink"))
    
    init() {
        if #available(iOS 17.0, *) {
            try? Tips.configure()
        }
    }

    var body: some Scene {
        WindowGroup {
            TabView(selection: tabSelection) {
                NavigationStack(path: $router.mainPath) {
                    MainView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.main)
                .tabItem {
                    Image.Home.Home.fill.icon()
                    Text(RootTab.main.title)
                }

                NavigationStack(path: $router.secondaryPath) {
                    BloodPressureChartsView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.secondary)
                .tabItem {
                    Image.Base.Chart.fill.icon()
                    Text(RootTab.secondary.title)
                }

                NavigationStack(path: $router.tertiaryPath) {
                    EmptyView()
                }
                .tag(RootTab.tertiary)
                .tabItem {
                    Image.Base.Plus.Square.fill.icon()
                    Text(RootTab.tertiary.title)
                }

                NavigationStack(path: $router.quaternaryPath) {
                    BloodPressureScreen()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.quaternary)
                .tabItem {
                    Image.Base.Clock.fill.icon()
                    Text(RootTab.quaternary.title)
                }

                NavigationStack(path: $router.settingsPath) {
                    SettingsView {
                        AppSettingsView()
                    }
                    .navigationDestination(for: Screen.self) { destination in
                        router.resolve(pathItem: destination)
                    }
                }
                .tag(RootTab.settings)
                .tabItem {
                    Image.Base.Setting.fill.icon()
                    Text(RootTab.settings.title)
                }
            }
            .appLaunch {
                OnboardingView()
            }
            .hud(router.hudText, isPresented: $router.isShowHud)
            .sheet(
                item: $router.sheet,
                content: { sheet in
                    NavigationStack(path: $router.sheetPath) {
                        router.resolve(pathItem: sheet)
                            .navigationDestination(for: Screen.self) { destination in
                                router.resolve(pathItem: destination)
                            }
                    }
                    .presentationDetents(router.sheetDetents)
                    .presentationDragIndicator(router.dragIndicator)
                    .interactiveDismissDisabled(router.dismissDisabled)
                    .environmentObject(appSettingsViewModel)
                    .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
                    .systemServices()
                }
            )
            .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
                router.resolve(pathItem: fullScreenCover)
                    .environmentObject(appSettingsViewModel)
                    .systemServices()
                    .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
            }
            .alert(item: $router.alert) { $0.alert }
            .onOpenURL { router.handle($0) }
            .environmentObject(router)
            .environmentObject(appSettingsViewModel)
            .modelContainer(for: Item.self)
            .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
            .onReceive(pub) { output in
                if let userInfo = output.userInfo, let info = userInfo["link"] {
                    let url = URL(string: info as! String)!
                    router.handle(url)
                }
            }
        }
    }

    private var tabSelection: Binding<RootTab> {
        .init {
            router.tab
        } set: { tab in
            switch tab {
            case .tertiary:
                router.present(.createBloodPressure, detents: [.height(365)], dismissDisabled: true)
            default:
                router.tab = tab
            }
        }
    }
}

       
