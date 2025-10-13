// ___FILEHEADER___

import Database
import OversizeLocalizable
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying ___VARIABLE_modelName___ lists
public struct ___VARIABLE_modelName___ListContentView: View {
    public enum Action: Sendable {
        case tapItem(___VARIABLE_modelName___)
        case editProduct(___VARIABLE_modelName___)
        case toggleFavorite(___VARIABLE_modelName___)
        case duplicateProduct(___VARIABLE_modelName___)
        case deleteProduct(___VARIABLE_modelName___)
        case selectCategory(___VARIABLE_modelName___, ___VARIABLE_categoryName___?)
        case createCategoryForProduct(___VARIABLE_modelName___)
    }

    private let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
    private let categories: [___VARIABLE_categoryName___]
    private let displayType: ___VARIABLE_modelName___ListDisplayType
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let gridSize: ___VARIABLE_modelName___GridSize
    private let onAction: (Action) -> Void

    public init(
        ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___],
        categories: [___VARIABLE_categoryName___] = [],
        displayType: ___VARIABLE_modelName___ListDisplayType = .list,
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        gridSize: ___VARIABLE_modelName___GridSize = .medium,
        onAction: @escaping (Action) -> Void
    ) {
        self.___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___
        self.categories = categories
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
            ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, viewOption: viewOption) {
                    onAction(.tapItem(___VARIABLE_modelVariableName___))
                }
                .contextMenu { contextMenu(for: ___VARIABLE_modelVariableName___).tint(Color.onSurfacePrimary) }
            }
        }
    }

    @ViewBuilder
    private var gridView: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)], spacing: 12) {
            ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___, viewOption: viewOption) {
                    onAction(.tapItem(___VARIABLE_modelVariableName___))
                }
                .contextMenu { contextMenu(for: ___VARIABLE_modelVariableName___).tint(Color.onSurfacePrimary) }
            }
        }
        .paddingContent()
    }

    @ViewBuilder
    private func contextMenu(for product: ___VARIABLE_modelName___) -> some View {
        Button(action: {
            onAction(.editProduct(product))
        }) {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }
        .tint(.onSurfacePrimary)

        Menu {
            Button(action: {
                onAction(.selectCategory(product, nil))
            }) {
                Label {
                    Text("No Category")
                } icon: {
                    if product.___VARIABLE_categoryVariableName___Id == nil {
                        Image.Base.Check.mini
                    }
                }
            }

            ForEach(categories) { category in
                Button(action: {
                    onAction(.selectCategory(product, category))
                }) {
                    Label {
                        Text(category.name)
                    } icon: {
                        if product.___VARIABLE_categoryVariableName___Id == category.id {
                            Image.Base.Check.mini
                        }
                    }
                }
            }

            Divider()

            Button(action: {
                onAction(.createCategoryForProduct(product))
            }) {
                Label {
                    Text("Create New")
                } icon: {
                    Image.Base.Plus.mini
                }
            }
        } label: {
            Label {
                Text("Category")
            } icon: {
                Image.Base.Folder.mini
            }
        }
        .menuStyle(.button)
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.toggleFavorite(product))
        }) {
            Label {
                Text(product.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                if product.isFavorite {
                    Image.Base.Unstar.mini
                } else {
                    Image.Base.Star.mini
                }
            }
        }
        .tint(.onSurfacePrimary)

        Button(action: {
            onAction(.duplicateProduct(product))
        }) {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }
        .tint(.onSurfacePrimary)

        Button(role: .destructive, action: {
            onAction(.deleteProduct(product))
        }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
        .tint(Color.error)
    }
}