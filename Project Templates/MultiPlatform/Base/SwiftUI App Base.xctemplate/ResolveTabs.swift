//___FILEHEADER___

import Env
import Foundation
import Main
import NavigatorUI
import OversizeKit
import OversizeRouter
import OversizeUI
import SwiftUI

extension RootTabs: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        RootTabsViewBuilder(destination: self)
    }
}

private struct RootTabsViewBuilder: View {
    @Environment(\.navigator) var navigator: Navigator
    let destination: RootTabs

    var body: some View {
        switch destination {
        case .main:
            MainNavigationStack()
        case .settings:
            AppSettingsNavigationStack()
        }
    }
}
