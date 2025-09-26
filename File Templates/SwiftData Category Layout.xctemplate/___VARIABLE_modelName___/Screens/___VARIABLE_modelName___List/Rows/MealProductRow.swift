//
// Copyright © 2025 Alexander Romanov
// MealProductRow.swift, created on 10.07.2025
//

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductRow: View {
    private let mealProduct: MealProduct
    private let isSelected: Bool
    private let viewOption: MealProductViewOption
    private let action: (() -> Void)?

    init(
        _ mealProduct: MealProduct,
        isSelected: Bool = false,
        viewOption: MealProductViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.mealProduct = mealProduct
        self.isSelected = isSelected
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        Row(
            mealProduct.name,
            subtitle: viewOption == .compact ? nil : mealProduct.date.formatted(date: .abbreviated, time: .shortened),
            action: action,
            trailing: {
                if mealProduct.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            },
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
}
