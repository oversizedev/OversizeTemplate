// ___FILEHEADER___

import OversizeArchitecture
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_productName___.self)
public struct ___FILEBASENAMEASIDENTIFIER___: ViewProtocol {
    public var body: some View {
        NavigationLayoutView("Title") {
            content
        } background: {
            Color.backgroundSecondary
        }
        .toolbarTitleDisplayMode(.inline)
    }

    var content: some View {
        Text("Content")
    }
}

#Preview {
    NavigationStack {
        ___VARIABLE_productName___.build()
    }
}
