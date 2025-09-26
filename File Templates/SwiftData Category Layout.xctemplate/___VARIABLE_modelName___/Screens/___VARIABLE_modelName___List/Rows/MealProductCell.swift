//
// Copyright © 2025 Alexander Romanov
// MealProductCell.swift, created on 10.07.2025
//

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductCell: View {
    private let mealProduct: MealProduct
    private let viewOption: MealProductViewOption
    private let action: (() -> Void)?

    init(
        _ mealProduct: MealProduct,
        viewOption: MealProductViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.mealProduct = mealProduct
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        VStack {
            Text(mealProduct.name)

            if viewOption == .standard {
                HStack {
                    Text(mealProduct.date.formatted(date: .abbreviated, time: .shortened))

                    if mealProduct.isFavorite {
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
