//___FILEHEADER___

import Env
import Main
import NavigatorUI
import Onboarding
import OversizeKit
import OversizeUI
import Settings
import SwiftUI

extension AppSettingsDestinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case .appSettings:
            AppSettings.build()
        }
    }
}

struct AppSettingsNavigationStack: View {
    let navigator: Navigator = .init(configuration: .init())

    var body: some View {
        ManagedNavigationStack(scene: "Settings") { nav in
            SettingsView {
                Row("App settings") {
                    nav.navigate(to: AppSettingsDestinations.appSettings)
                } leading: {
                    Image.Base.setting.icon()
                }
                .rowArrow()
                .buttonStyle(.row)
            }
            .navigationAutoReceive(AppSettingsDestinations.self)
            .coreServices()
        }
        .navigationRoot(navigator)
    }
}
