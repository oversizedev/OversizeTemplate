// ___FILEHEADER___

import OversizeComponents
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___PlaceholderView: View {
    let displayType: ___VARIABLE_modelName___ListDisplayType
    let gridSize: ___VARIABLE_modelName___ListGridSize

    init(displayType: ___VARIABLE_modelName___ListDisplayType, gridSize: ___VARIABLE_modelName___ListGridSize = .medium) {
        self.displayType = displayType
        self.gridSize = gridSize
    }

    var body: some View {
        switch displayType {
        case .list:
            listPlaceholders
        case .grid:
            gridPlaceholders
        }
    }

    @ViewBuilder
    private var listPlaceholders: some View {
        LazyVStack(spacing: .zero) {
            ForEach(0..<8, id: \.self) { _ in
                rowPlaceholder
            }
        }
    }

    @ViewBuilder
    private var gridPlaceholders: some View {
        LazyVGrid(columns: gridColumns, spacing: 12) {
            ForEach(0..<6, id: \.self) { _ in
                cellPlaceholder
            }
        }
    }

    @ViewBuilder
    private var rowPlaceholder: some View {
        Row {
            HStack(spacing: .small) {
                // Image placeholder
                RoundedRectangle(cornerRadius: .small)
                    .fill(Color.surfaceTertiary)
                    .frame(width: 44, height: 44)
                    .shimmering()
                
                VStack(alignment: .leading, spacing: .xxSmall) {
                    // Title placeholder
                    RoundedRectangle(cornerRadius: .xSmall)
                        .fill(Color.surfaceTertiary)
                        .frame(height: 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .shimmering()
                    
                    // Subtitle placeholder
                    RoundedRectangle(cornerRadius: .xSmall)
                        .fill(Color.surfaceTertiary)
                        .frame(height: 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .scaleEffect(x: 0.7, anchor: .leading)
                        .shimmering()
                }
                
                Spacer()
                
                // Trailing content placeholder
                VStack(alignment: .trailing, spacing: .xxSmall) {
                    RoundedRectangle(cornerRadius: .xSmall)
                        .fill(Color.surfaceTertiary)
                        .frame(width: 60, height: 10)
                        .shimmering()
                    
                    RoundedRectangle(cornerRadius: .xSmall)
                        .fill(Color.surfaceTertiary)
                        .frame(width: 40, height: 8)
                        .shimmering()
                }
            }
        }
        .disabled(true)
    }

    @ViewBuilder
    private var cellPlaceholder: some View {
        VStack(alignment: .leading, spacing: .small) {
            // Image placeholder
            RoundedRectangle(cornerRadius: .small)
                .fill(Color.surfaceTertiary)
                .frame(height: imageHeight)
                .frame(maxWidth: .infinity)
                .shimmering()
            
            VStack(alignment: .leading, spacing: .xxSmall) {
                // Title placeholder
                RoundedRectangle(cornerRadius: .xSmall)
                    .fill(Color.surfaceTertiary)
                    .frame(height: 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .shimmering()
                
                // Note placeholder
                RoundedRectangle(cornerRadius: .xSmall)
                    .fill(Color.surfaceTertiary)
                    .frame(height: 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .scaleEffect(x: 0.8, anchor: .leading)
                    .shimmering()
            }
            
            // Metadata placeholder
            HStack {
                RoundedRectangle(cornerRadius: .xSmall)
                    .fill(Color.surfaceTertiary)
                    .frame(width: 50, height: 8)
                    .shimmering()
                
                Spacer()
                
                RoundedRectangle(cornerRadius: .xSmall)
                    .fill(Color.surfaceTertiary)
                    .frame(width: 30, height: 8)
                    .shimmering()
            }
        }
        .padding(.medium)
        .frame(height: cellHeight)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
    }

    // MARK: - Computed Properties

    private var gridColumns: [GridItem] {
        [GridItem(.adaptive(minimum: gridSize.columnWidth), spacing: 12)]
    }

    private var cellHeight: CGFloat {
        switch gridSize {
        case .small:
            return 180
        case .medium:
            return 220
        case .large:
            return 260
        }
    }

    private var imageHeight: CGFloat {
        switch gridSize {
        case .small:
            return 80
        case .medium:
            return 100
        case .large:
            return 120
        }
    }
}
