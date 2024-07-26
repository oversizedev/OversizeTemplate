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
            subtitle: isCompact ? nil : ___VARIABLE_modelVariableName___.date?.displayTodayLabelOrDate,
            action: action
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimaryHighEmphasis : Color.onSurfaceHighEmphasis)
        #endif
    }
}

#Preview { @MainActor in
    ___VARIABLE_modelName___Row(___VARIABLE_modelName___(
        id: UUID(),
        name: "Link",
        url: URL(string: "http://oversize.app")!,
        color: Color.red
    ))
}
