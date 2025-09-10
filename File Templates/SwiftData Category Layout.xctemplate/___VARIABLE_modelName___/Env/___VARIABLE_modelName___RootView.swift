// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public struct ___VARIABLE_modelName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_modelName___ListScreen.build()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .coreServices()
    }
}