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
                Text("Choose a category")
            }
        }
    }
}

#Preview { @MainActor in
    ___VARIABLE_modelName___SplitDetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___(
        id: UUID(),
        name: "Link",
        url: URL(string: "http://oversize.app")!,
        color: Color.red
    ))
}
