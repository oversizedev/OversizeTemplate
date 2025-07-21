// ___FILEHEADER___

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let isCompact: Bool
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        isCompact: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.isCompact = isCompact
        self.action = action
    }

    var body: some View {
        Row(
            ___VARIABLE_modelVariableName___.name,
            subtitle: isCompact ? nil : subtitle,
            action: action
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
    
    private var subtitle: String {
        if ___VARIABLE_modelVariableName___.calories > 0 {
            return "\(Int(___VARIABLE_modelVariableName___.calories)) kcal • \(___VARIABLE_modelVariableName___.category)"
        } else {
            return ___VARIABLE_modelVariableName___.category
        }
    }
}
