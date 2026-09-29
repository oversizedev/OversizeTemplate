//___FILEHEADER___

import Env
import NavigatorUI
import OversizeNavigation
import SwiftUI

struct RootView: View {
    @State private var navigator: Navigator = .init(configuration: .init())
    @SceneStorage("RootView.selectedTab") private var selectedTab: RootTabs = .main

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(RootTabs.tabs) { tab in
                Tab(value: tab) {
                    tab
                } label: {
                    Label {
                        Text(tab.title)
                    } icon: {
                        tab.icon
                    }
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .defaultAdaptableTabBarPlacement(.sidebar)
        .tabViewSidebarHeader {
            Text("___PACKAGENAME___")
                .font(.title2.bold())
        }
        .onNavigationReceive(assign: $selectedTab)
        .navigationRoot(navigator)
    }
}

#Preview {
    RootView()
}
