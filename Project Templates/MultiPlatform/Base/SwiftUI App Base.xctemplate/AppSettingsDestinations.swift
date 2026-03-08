//___FILEHEADER___

import Env
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
    var body: some View {
        ManagedNavigationStack(scene: RootTabs.settings.id) { nav in
            SettingsView {
                Row("App settings") {
                    nav.navigate(to: AppSettingsDestinations.appSettings)
                } leading: {
                    Image.Base.setting.icon()
                }
                .rowArrow()
                .buttonStyle(.row)
            }
            .navigationDestination(AppSettingsDestinations.self)
            .navigationAutoReceive(SettingsDestinations.self)
        }
        .coreServices()
    }
}
