// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        ListRow(
            ___VARIABLE_modelVariableName___.name,
            subtitle: viewOption == .compact ? nil : ___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened),
            trailing: {
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            },
            action: action
        )
    }
}
