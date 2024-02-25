//___FILEHEADER___

import SwiftUI
import SwiftData

@main
struct ___PACKAGENAME:identifier___App: App {

    @Injected(\.appStateService) var appStateService: AppStateService
    @ObservedObject private var router = Router()
    @StateObject private var appSettingsViewModel = AppSettingsViewModel()
    let pub = NotificationCenter.default.publisher(for: NSNotification.Name("Deeplink"))
    
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
                    Image.Base.Home.fill.icon()
                    Text(RootTab.main.title)
                }

                NavigationStack(path: $router.secondaryPath) {
                    EmptyView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.secondary)
                .tabItem {
                    Image.Base.Home.fill.icon()
                    Text(RootTab.secondary.title)
                }

                NavigationStack(path: $router.tertiaryPath) {
                    EmptyView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.tertiary)
                .tabItem {
                    Image.Base.Home.fill.icon()
                    Text(RootTab.tertiary.title)
                }

                NavigationStack(path: $router.quaternaryPath) {
                    EmptyView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.quaternary)
                .tabItem {
                    Image.Base.Home.fill.icon()
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
                    Image.Base.Home.fill.icon()
                    Text(RootTab.settings.title)
                }
            }
            .appLaunch {
                OnboardingView()
            }
            .hud(router.hudText, isPresented: $router.isShowHud)
            .sheet(item: $router.sheet) { sheet in
                NavigationStack {
                    router.resolveSheet(pathItem: sheet, detents: router.sheetDetents, dragIndicator: router.dragIndicator, dismissDisabled: router.dismissDisabled)
                        .hud(router.hudText, isPresented: $router.isShowHud)
                        .alert(item: $router.alert) { $0.alert }
                        .environmentObject(appSettingsViewModel)
                        .systemServices()
                }
            }
            .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
                NavigationStack {
                    router.resolve(pathItem: fullScreenCover)
                        .hud(router.hudText, isPresented: $router.isShowHud)
                        .alert(item: $router.alert) { $0.alert }
                        .environmentObject(appSettingsViewModel)
                        .systemServices()
                }
            }
            .alert(item: $router.alert) { $0.alert }
            .onOpenURL { router.handle($0) }
            .environmentObject(router)
            .environmentObject(appSettingsViewModel)
            .modelContainer(for: Item.self)
            .onReceive(pub) { output in
                if let userInfo = output.userInfo, let info = userInfo["link"] {
                    let url = URL(string: info as! String)!
                    router.handle(url)
                }
            }
    }
        
    private var tabSelection: Binding<RootTab> {
        .init {
            router.tab
        } set: { newValue in
            router.tab = newValue
        }
    }
}
