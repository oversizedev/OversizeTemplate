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
        VStack {
            Text("Title")
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
