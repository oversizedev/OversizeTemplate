//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryPlaceholderView.swift, created on 27.07.2025
//

import OversizeUI
import SwiftUI

struct MealProductCategoryPlaceholderView: View {
    let displayType: MealProductCategoryListDisplayType
    let gridSize: MealProductCategoryGridSize

    init(displayType: MealProductCategoryListDisplayType, gridSize: MealProductCategoryGridSize = .medium) {
        self.displayType = displayType
        self.gridSize = gridSize
    }

    var body: some View {
        switch displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(0 ... 3, id: \.self) { _ in
                    Row("Title", subtitle: "Subtitle")
                }
            }
            .redacted(reason: .placeholder)
        case .grid:
            LazyVGrid(
                columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)],
                spacing: 12,
            ) {
                ForEach(0 ... 8, id: \.self) { _ in
                    VStack {
                        Text("Title")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: .medium)
                            .fill(Color.surfaceSecondary)
                    }
                    .redacted(reason: .placeholder)
                }
            }
            .redacted(reason: .placeholder)
        }
    }
}
