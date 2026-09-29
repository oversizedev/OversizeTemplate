//___FILEHEADER___

import Env
import NavigatorUI
import OversizeKit
import Settings
import SwiftUI

struct AppSettingsNavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: RootTabs.settings.id) {
            AppSettings.buildCached()
                .navigationAutoReceive(AppSettingsDestinations.self)
        }
        .appEnvironment()
    }
}

#Preview {
    AppSettingsNavigationStack()
}
