// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___ListContentView: View {
    let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    let onTapCategory: (___VARIABLE_categoryName___) -> Void

    public var body: some View {
        LazyVStack(spacing: .zero) {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                ___VARIABLE_categoryName___Row(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
                    .onTapGesture {
                        onTapCategory(___VARIABLE_categoryVariableName___)
                    }
            }
        }
        .paddingContent()
    }
}