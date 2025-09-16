//___FILEHEADER___

import OversizeUI
import SwiftUI

public struct ___VARIABLE_categoryName___PlaceholderView: View {
    private let displayType: ___VARIABLE_categoryName___ListDisplayType
    private let gridSize: ___VARIABLE_categoryName___GridSize

    public init(
        displayType: ___VARIABLE_categoryName___ListDisplayType,
        gridSize: ___VARIABLE_categoryName___GridSize = .medium
    ) {
        self.displayType = displayType
        self.gridSize = gridSize
    }

    public var body: some View {
        switch displayType {
        case .list:
            listPlaceholder
        case .grid:
            gridPlaceholder
        }
    }

    private var listPlaceholder: some View {
        LazyVStack(spacing: .zero) {
            ForEach(0..<6, id: \.self) { _ in
                rowPlaceholder
            }
        }
        .paddingContent()
    }

    private var gridPlaceholder: some View {
        LazyVGrid(
            columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)],
            spacing: 12
        ) {
            ForEach(0..<6, id: \.self) { _ in
                cellPlaceholder
            }
        }
        .paddingContent()
    }

    private var rowPlaceholder: some View {
        HStack(spacing: .medium) {
            // Leading icon placeholder
            Circle()
                .fill(.regularMaterial)
                .frame(width: 40, height: 40)

            VStack(alignment: .leading, spacing: .xSmall) {
                // Title placeholder
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Subtitle placeholder
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(width: 120, height: 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer()

            // Trailing content placeholder
            VStack(alignment: .trailing, spacing: .xSmall) {
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(width: 80, height: 12)

                Rectangle()
                    .fill(.regularMaterial)
                    .frame(width: 40, height: 12)
            }
        }
        .padding(.medium)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: .medium))
        .redacted(reason: .placeholder)
    }

    private var cellPlaceholder: some View {
        VStack(spacing: .medium) {
            HStack {
                // Leading icon placeholder
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 40, height: 40)

                Spacer()

                // Favorite icon placeholder
                Circle()
                    .fill(.regularMaterial)
                    .frame(width: 16, height: 16)
            }

            VStack(spacing: .small) {
                // Title placeholder
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Subtitle placeholder
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 16)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Note placeholder
                Rectangle()
                    .fill(.regularMaterial)
                    .frame(height: 32)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer()

            // Footer placeholder
            HStack {
                VStack(alignment: .leading, spacing: .xSmall) {
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 60, height: 12)

                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 40, height: 12)
                }

                Spacer()
            }
        }
        .padding(.medium)
        .frame(height: 160)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: .medium))
        .redacted(reason: .placeholder)
    }
}