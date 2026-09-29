//___FILEHEADER___

import Env
import NavigatorUI
import Settings
import SwiftUI

extension AppSettingsDestinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case .___VARIABLE_modelVariableName___Settings:
            ___VARIABLE_modelName___Settings.build()
        }
    }
}
