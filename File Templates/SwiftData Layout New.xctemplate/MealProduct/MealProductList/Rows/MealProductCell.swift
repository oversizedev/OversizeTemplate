// ___FILEHEADER___

import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct MealProductCell: View {
    private let mealProduct: MealProduct
    private let action: (() -> Void)?

    init(
        _ mealProduct: MealProduct,
        action: (() -> Void)? = nil
    ) {
        self.mealProduct = mealProduct
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            if let image = mealProduct.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(.small)
            }
            
            VStack(alignment: .leading, spacing: .xxSmall) {
                Text(mealProduct.name)
                    .headline(.medium)
                    .foregroundColor(.onSurfacePrimary)
                    .lineLimit(2)
                
                if mealProduct.calories > 0 {
                    Text("\(Int(mealProduct.calories)) kcal")
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                
                Text(mealProduct.category)
                    .caption(.medium)
                    .foregroundColor(.onSurfaceTertiary)
            }
            .padding(.horizontal, .small)
            .padding(.bottom, .small)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
