//___FILEHEADER___

import Env
import NavigatorUI
import SwiftUI

extension RootType: @retroactive NavigationDestination {
    public var body: some View {
        switch self {
        case .tabbed:
            RootTabView()
        case .split:
            RootSplitView()
        }
    }
}
