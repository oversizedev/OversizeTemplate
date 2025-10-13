// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Row: View {
    private let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    private let isSelected: Bool
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        isSelected: Bool = false,
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        action: (() -> Void)? = nil,
    ) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.isSelected = isSelected
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        Row(
            ___VARIABLE_categoryVariableName___.name,
            subtitle: viewOption == .compact ? nil : ___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .shortened),
            action: action,
            trailing: {
                if ___VARIABLE_categoryVariableName___.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            },
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
}