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
            image: nil,
            title: "No ___VARIABLE_modelPluralVariableName___",
            subtitle: "Add your first ___VARIABLE_modelVariableName___ to get started",
            primaryButton: .primary(
                "Add ___VARIABLE_modelName___",
                action: {
                    action()
                }))
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
