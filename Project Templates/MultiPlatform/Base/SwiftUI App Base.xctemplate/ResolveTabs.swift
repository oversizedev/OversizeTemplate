//___FILEHEADER___

import Env
import SwiftUI

extension RootTabs: @retroactive View {
    public var body: some View {
        switch self {
        case .main:
            MainNavigationStack()

        case .settings:
            AppSettingsNavigationStack()
        }
    }
}
