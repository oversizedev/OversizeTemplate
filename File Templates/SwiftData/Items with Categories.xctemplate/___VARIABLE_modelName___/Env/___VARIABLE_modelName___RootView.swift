// ___FILEHEADER___

import NavigatorUI
import SwiftUI

public struct ___VARIABLE_modelName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_modelName___List.build()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .coreServices()
    }
}

public struct ___VARIABLE_categoryName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_categoryName___List.build()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .coreServices()
    }
}