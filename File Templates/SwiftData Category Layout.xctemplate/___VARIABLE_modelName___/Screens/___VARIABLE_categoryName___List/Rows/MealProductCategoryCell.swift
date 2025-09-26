//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryCell.swift, created on 27.07.2025
//

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductCategoryCell: View {
    private let mealProductCategory: MealProductCategory
    private let viewOption: MealProductCategoryViewOption
    private let action: (() -> Void)?

    init(
        _ mealProductCategory: MealProductCategory,
        viewOption: MealProductCategoryViewOption = .standard,
        action: (() -> Void)? = nil,
    ) {
        self.mealProductCategory = mealProductCategory
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        VStack {
            Text(mealProductCategory.name)

            if viewOption == .standard {
                HStack {
                    Text(mealProductCategory.date.formatted(date: .abbreviated, time: .shortened))

                    if mealProductCategory.isFavorite {
                        Image.Base.Star.fill.icon(Color.warning)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
