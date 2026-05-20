//___FILEHEADER___

import Env
import NavigatorUI
import OversizeRouter
import SwiftUI

struct RootTabView: View {
    @SceneStorage("AppState.SelectedRootTab") var selectedTab: RootTabs = .main
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.tabs) { tab in
                tab.tabItem {
                    Label {
                        Text(tab.title)
                    } icon: {
                        tab.icon
                    }
                }
                .tag(tab)
            }
        }
        .onNavigationReceive(assign: $selectedTab)
    }
}
