//___FILEHEADER___

import Env
import Main
import NavigatorUI
import OversizeKit
import SwiftUI

struct MainNavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: RootTabs.main.id) {
            Main.buildCached()
                .navigationAutoReceive(MainDestinations.self)
        }
        .appEnvironment()
    }
}

#Preview {
    MainNavigationStack()
}
