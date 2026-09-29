//___FILEHEADER___

import Env
import OversizeRouter
import SwiftUI

struct RootTabView: View {
    @SceneStorage("AppState.SelectedRootTab") var selectedTab: RootTabs = .main
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.tabs) { tab in
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
    }
}

struct RootSplitView: View {
    @State var selectedTab: RootTabs? = .main
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedTab: $selectedTab)
                .navigationSplitViewColumnWidth(200)
        } detail: {
            selectedTab
        }
    }
}

private struct SidebarView: View {
    @Binding var selectedTab: RootTabs?
    var body: some View {
        List(selection: $selectedTab) {
            Section("Menu") {
                ForEach(RootTabs.sidebar) { tab in
                    NavigationLink(value: tab) {
                        Label {
                            Text(tab.title)
                        } icon: {
                            tab.icon
                        }
                    }
                }
            }
        }
    }
}
