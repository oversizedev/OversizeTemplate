//___FILEHEADER___

import Env
import Main
import NavigatorUI
import OversizeKit
import SwiftUI

extension MainDestinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case .detail:
            Text("Detail")
        }
    }
}

struct MainNavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: RootTabs.main.id) {
            Main.buildCached()
                .navigationAutoReceive(MainDestinations.self)
        }
        .coreServices()
    }
}
