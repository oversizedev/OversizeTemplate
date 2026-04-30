// ___FILEHEADER___

import Database
import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying ___VARIABLE_categoryName___ lists
public struct ___VARIABLE_categoryName___ListContentView: View {
    public enum Action: Sendable {
        case onTapItem(___VARIABLE_categoryName___)
        case onTapEditCategory(___VARIABLE_categoryName___)
        case onTapToggleFavorite(___VARIABLE_categoryName___)
        case onTapDuplicateCategory(___VARIABLE_categoryName___)
        case onTapDeleteCategory(___VARIABLE_categoryName___)
    }

    private let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    private let displayType: ___VARIABLE_categoryName___ListDisplayType
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let gridSize: ___VARIABLE_categoryName___GridSize
    private let onAction: (Action) -> Void

    public init(
        ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___],
        displayType: ___VARIABLE_categoryName___ListDisplayType = .list,
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        gridSize: ___VARIABLE_categoryName___GridSize = .medium,
        onAction: @escaping (Action) -> Void
    ) {
        self.___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryPluralVariableName___
        self.displayType = displayType
        self.viewOption = viewOption
        self.gridSize = gridSize
        self.onAction = onAction
    }

    public var body: some View {
        switch displayType {
        case .list:
            listView
        case .grid:
            gridView
        }
    }

    @ViewBuilder
    private var listView: some View {
        LazyVStack(spacing: .zero) {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                ___VARIABLE_categoryName___Row(___VARIABLE_categoryVariableName___, viewOption: viewOption) {
                    onAction(.onTapItem(___VARIABLE_categoryVariableName___))
                }
                .contextMenu { contextMenu(for: ___VARIABLE_categoryVariableName___) }
            }
        }
    }

    @ViewBuilder
    private var gridView: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)], spacing: 12) {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                ___VARIABLE_categoryName___Cell(___VARIABLE_categoryVariableName___, viewOption: viewOption) {
                    onAction(.onTapItem(___VARIABLE_categoryVariableName___))
                }
                .contextMenu { contextMenu(for: ___VARIABLE_categoryVariableName___) }
            }
        }
        .paddingContent()
    }

    @ViewBuilder
    private func contextMenu(for category: ___VARIABLE_categoryName___) -> some View {
        Button(action: {
            onAction(.onTapEditCategory(category))
        }) {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.onTapToggleFavorite(category))
        }) {
            Label {
                Text(category.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                if category.isFavorite {
                    Image.Base.Unstar.mini
                } else {
                    Image.Base.Star.mini
                }
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.onTapDuplicateCategory(category))
        }) {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(role: .destructive, action: {
            onAction(.onTapDeleteCategory(category))
        }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(.error)
    }
}