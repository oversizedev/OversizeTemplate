//___FILEHEADER___

import NavigatorUI
import SwiftUI

struct RootView: View {
    @State private var navigator: Navigator = .init(configuration: .init())

    var body: some View {
        MainNavigationStack()
            .navigationRoot(navigator)
    }
}

#Preview {
    RootView()
}
