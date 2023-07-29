// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @Environment(\.screenSize) var screenSize

    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        ContentView(image: Image("Empty", bundle: .main),
                    title: "Not ___VARIABLE_CoreDataModelVariableMany___",
                    subtitle: "Add the first ___VARIABLE_CoreDataModelVariable___",
                    primaryButton: .primary("Add ___VARIABLE_CoreDataModelVariable___", action: {
                        action()

                    }))
                    .padding(.top, .xLarge)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .medium)
                    .paddingContent()
                    .padding(.top, screenSize.height < 670 ? -70 : 0)
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___() {}
    }
}
