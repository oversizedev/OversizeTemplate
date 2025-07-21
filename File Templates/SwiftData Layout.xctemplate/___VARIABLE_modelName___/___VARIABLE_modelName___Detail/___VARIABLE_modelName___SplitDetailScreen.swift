// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeCore
import OversizeLocalizable
import OversizeUI
import OversizeRouter
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___SplitDetailScreen: View {
    @Environment(Router<Screen>.self) var router
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___?

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___?) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
    }

    public var body: some View {
        ZStack {
            if let ___VARIABLE_modelVariableName___ {
                ___VARIABLE_modelName___DetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            } else {
                ContentView(
                    title: "Select a ___VARIABLE_modelName___",
                    subtitle: "Choose an item from the list to view details"
                )
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview { @MainActor in
    ___VARIABLE_modelName___SplitDetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___(
        name: "Sample ___VARIABLE_modelName___",
        color: Color.accentColor,
        date: Date.now,
        note: "Sample note"
    ))
    .modelContainer(___VARIABLE_modelVariableName___PreviewContainer)
}