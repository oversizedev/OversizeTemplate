//___FILEHEADER___

import Env
import Main
import NavigatorUI
import OversizeKit
import SwiftUI

struct MainNavigationStack: View {
    @State private var isSettingsPresented = false

    var body: some View {
        ManagedNavigationStack(scene: RootTabs.main.id) {
            Main.buildCached()
                .navigationAutoReceive(MainDestinations.self)
                .toolbar { toolbarContent }
        }
        .sheet(isPresented: $isSettingsPresented) {
            AppSettingsNavigationStack()
        }
        .appEnvironment()
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button {
                isSettingsPresented = true
            } label: {
                Label {
                    Text(RootTabs.settings.title)
                } icon: {
                    RootTabs.settings.icon
                }
            }
        }
    }
}

#Preview {
    MainNavigationStack()
}
