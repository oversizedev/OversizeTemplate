//___FILEHEADER___

import Env
import NavigatorUI
import OversizeRouter
import SwiftUI

struct RootSplitView: View {
    @State var selectedTab: RootTabs? = .main
    var body: some View {
        NavigationSplitView {
            SidebarView(selectedTab: $selectedTab)
                .navigationSplitViewColumnWidth(200)
        } detail: {
            selectedTab
        }
        .onNavigationReceive(assign: $selectedTab, delay: 0.8)
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
