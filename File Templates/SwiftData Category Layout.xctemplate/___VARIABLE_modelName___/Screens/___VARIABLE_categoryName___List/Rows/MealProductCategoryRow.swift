//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryRow.swift, created on 27.07.2025
//

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductCategoryRow: View {
    private let mealProductCategory: MealProductCategory
    private let isSelected: Bool
    private let viewOption: MealProductCategoryViewOption
    private let action: (() -> Void)?

    init(
        _ mealProductCategory: MealProductCategory,
        isSelected: Bool = false,
        viewOption: MealProductCategoryViewOption = .standard,
        action: (() -> Void)? = nil,
    ) {
        self.mealProductCategory = mealProductCategory
        self.isSelected = isSelected
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        Row(
            mealProductCategory.name,
            subtitle: viewOption == .compact ? nil : mealProductCategory.date.formatted(date: .abbreviated, time: .shortened),
            action: action,
            trailing: {
                if mealProductCategory.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            },
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
}
