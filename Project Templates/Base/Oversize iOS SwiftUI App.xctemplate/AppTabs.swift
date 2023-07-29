//___FILEHEADER___

import Factory
import OversizeKit
import OversizeServices
import OversizeUI
import SwiftUI

@main
struct ___PACKAGENAME:identifier___App: App {
    
    @Injected(\.appStateService) var appStateService: AppStateService
    @ObservedObject private var router = Router()
    @StateObject private var appSettingsViewModel = AppSettingsViewModel()
    let pub = NotificationCenter.default.publisher(for: NSNotification.Name("Deeplink"))
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.tab) {
                NavigationStack(path: $router.mainPath) {
                    MainView()
                        .navigationDestination(for: Screen.self) { destination in
                            router.resolve(pathItem: destination)
                        }
                }
                .tag(RootTab.main)
                .tabItem {
                    RootTab.main.image
                        .renderingMode(.template)
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
                    RootTab.secondary.image
                        .renderingMode(.template)
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
                    RootTab.tertiary.image
                        .renderingMode(.template)
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
                    RootTab.quaternary.image
                        .renderingMode(.template)
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
                    Icons.Base.setting.solid
                        .renderingMode(.template)
                    Text(RootTab.settings.title)
                }
            }
            .appLaunch {
                OnboardingView()
            }
            .hud(router.hudText, isPresented: $router.isShowHud)
            .sheet(item: $router.sheet) { sheet in
                router.resolveSheet(pathItem: sheet, detents: router.sheetDetents, dragIndicator: router.dragIndicator, dismissDisabled: router.dismissDisabled)
                    .hud(router.hudText, isPresented: $router.isShowHud)
                    .alert(item: $router.alert) { $0.alert }
                    .environmentObject(appSettingsViewModel)
                    .systemServices()
            }
            .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
                router.resolve(pathItem: fullScreenCover)
                    .hud(router.hudText, isPresented: $router.isShowHud)
                    .alert(item: $router.alert) { $0.alert }
                    .environmentObject(appSettingsViewModel)
                    .systemServices()
            }
            .alert(item: $router.alert) { $0.alert }
            .onOpenURL { router.handle($0) }
            .environmentObject(router)
            .environmentObject(appSettingsViewModel)
            .onReceive(pub) { output in
                if let userInfo = output.userInfo, let info = userInfo["link"] {
                    let url = URL(string: info as! String)!
                    router.handle(url)
                }
            }
        }
    }
}
