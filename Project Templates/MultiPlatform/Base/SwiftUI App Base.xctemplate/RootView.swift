//___FILEHEADER___

import Env
import NavigatorUI
import OversizeRouter
import SwiftUI

struct RootTabView: View {
    @SceneStorage("AppState.SelectedRootTab") var selectedTab: RootTab = .main
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTab.tabs) { tab in
                tab
                    .tabItem {
                        Label {
                            Text(tab.title)
                        } icon: {
                            tab.icon
                        }
                    }
                    .tag(tab)
            }
        }
        .onNavigationReceive { (tab: MainTab) in
            if tab == selectedTab {
                return .immediately
            }
            selectedTab = tab
            return .after(0.7)
        }
    }
}
