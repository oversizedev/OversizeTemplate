// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___PlaceholderView: View {
    let displayType: ___VARIABLE_categoryName___ListDisplayType
    let gridSize: ___VARIABLE_categoryName___GridSize

    init(displayType: ___VARIABLE_categoryName___ListDisplayType, gridSize: ___VARIABLE_categoryName___GridSize = .medium) {
        self.displayType = displayType
        self.gridSize = gridSize
    }

    var body: some View {
        switch displayType {
        case .list:
            listPlaceholder
        case .grid:
            gridPlaceholder
        }
    }

    private var listPlaceholder: some View {
        LazyVStack(spacing: .zero) {
            ForEach(0 ..< 8, id: \.self) { _ in
                RowPlaceholder()
            }
        }
    }

    private var gridPlaceholder: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)], spacing: 12) {
            ForEach(0 ..< 12, id: \.self) { _ in
                CellPlaceholder()
                    .aspectRatio(1.0, contentMode: .fit)
            }
        }
        .paddingContent()
    }
}

#Preview {
    ___VARIABLE_categoryName___PlaceholderView(displayType: .list)
}