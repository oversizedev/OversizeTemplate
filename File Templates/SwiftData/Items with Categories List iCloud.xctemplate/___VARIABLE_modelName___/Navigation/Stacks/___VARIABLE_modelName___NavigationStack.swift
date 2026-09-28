// ___FILEHEADER___

import Env
import Main
import NavigatorUI
import OversizeKit
import SwiftUI

struct ___VARIABLE_modelName___NavigationStack: View {
    var body: some View {
        ManagedNavigationStack(scene: RootTabs.main.id) {
            ___VARIABLE_modelName___List.buildCached()
                .navigationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .appEnvironment()
    }
}

#Preview {
    ___VARIABLE_modelName___NavigationStack()
}
