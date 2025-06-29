// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___EmptyView: View {
    @Environment(\.screenSize) var screenSize

    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        ContentView(
            image: Image("Illustrations/Empty", bundle: .module),
            title: "No items",
            subtitle: "Add the first item",
            primaryButton: .primary(
                "Add item",
                action: {
                    action()
                }
            )
        )
        .padding(.top, .xLarge)
        .multilineTextAlignment(.center)
        .padding(.horizontal, .medium)
        .paddingContent()
        .padding(.top, screenSize.height < 670 ? -70 : 0)
    }
}

#Preview {
    ___VARIABLE_modelName___EmptyView(action: {})
}
