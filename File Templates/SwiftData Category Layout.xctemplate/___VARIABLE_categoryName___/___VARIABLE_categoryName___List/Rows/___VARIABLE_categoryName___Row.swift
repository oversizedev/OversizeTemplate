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

public struct ___VARIABLE_categoryName___Row: View {
    let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___

    public var body: some View {
        Row(
            ___VARIABLE_categoryVariableName___.name,
            subtitle: ___VARIABLE_categoryVariableName___.___VARIABLE_modelPluralVariableName___.count.description + " ___VARIABLE_modelPluralVariableName___",
            leading: {
                Circle()
                    .fill(___VARIABLE_categoryVariableName___.color)
                    .frame(width: 16, height: 16)
            }
        )
    }
}