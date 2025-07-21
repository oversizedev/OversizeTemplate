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
            mealProduct.name,
            subtitle: isCompact ? nil : subtitle,
            action: action
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
    
    private var subtitle: String {
        if mealProduct.calories > 0 {
            return "\(Int(mealProduct.calories)) kcal • \(mealProduct.category)"
        } else {
            return mealProduct.category
        }
    }
}
