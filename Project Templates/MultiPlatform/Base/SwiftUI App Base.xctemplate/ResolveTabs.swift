//___FILEHEADER___

import App
import Env
import Foundation
import NavigatorUI
import OversizeKit
import OversizeNavigation
import SwiftUI

extension RootTabs: @retroactive NavigationDestination {
    public var body: some View {
        RootTabsViewBuilder(destination: self)
    }
}

private struct RootTabsViewBuilder: View {
    let destination: RootTabs
    var body: some View {
        switch destination {
        case .main:
            EmptyView()
        case .settings:
            SettingsNavigationStack {
                EmptyView()
            }
        }
    }
}
