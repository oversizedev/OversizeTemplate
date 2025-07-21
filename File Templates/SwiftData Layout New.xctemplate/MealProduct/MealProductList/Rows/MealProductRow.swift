// ___FILEHEADER___

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductRow: View {
    private let mealProduct: MealProduct
    private let isSelected: Bool
    private let isCompact: Bool
    private let action: (() -> Void)?

    init(
        _ mealProduct: MealProduct,
        isSelected: Bool = false,
        isCompact: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.mealProduct = mealProduct
        self.isSelected = isSelected
        self.isCompact = isCompact
        self.action = action
    }

    var body: some View {
        Row(
            "Title",
            subtitle: isCompact ? nil : "Subtitle",
            action: action
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
}
