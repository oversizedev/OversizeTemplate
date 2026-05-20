//___FILEHEADER___

import Env
import NavigatorUI
import SwiftUI

struct RootView: View {
    let navigator: Navigator = .init(configuration: .init())
    @SceneStorage("AppState.RootType") var appRootType: RootType = UIDevice.current.userInterfaceIdiom == .pad ? .split : .tabbed

    var body: some View {
        appRootType
            .onNavigationReceive { (_: ToogleAppRootType) in
                appRootType = appRootType == .split ? .tabbed : .split
                return .auto
            }
            .navigationRoot(navigator)
    }
}
