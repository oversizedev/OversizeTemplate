// ___FILEHEADER___

import NavigatorUI
import OversizeKit
import SwiftUI

public struct ___VARIABLE_categoryName___NavigationStack: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_categoryName___List.buildCached()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .appEnvironment()
    }
}
