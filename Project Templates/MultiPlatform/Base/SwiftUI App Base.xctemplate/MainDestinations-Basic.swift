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
    let navigator: Navigator = .init(configuration: .init())

    var body: some View {
        ManagedNavigationStack {
            Main.buildCached()
                .navigationAutoReceive(MainDestinations.self)
        }
        .coreServices()
        .navigationRoot(navigator)
    }
}
