//
// Copyright © 2025 Alexander Romanov
// MealProductListContentView.swift, created on 29.07.2025
//

import Database
import OversizeLocalizable
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying MealProduct lists
public struct MealProductListContentView: View {
    public enum Action: Sendable {
        case tapItem(MealProduct)
        case editProduct(MealProduct)
        case toggleFavorite(MealProduct)
        case duplicateProduct(MealProduct)
        case deleteProduct(MealProduct)
        case selectCategory(MealProduct, MealProductCategory?)
        case createCategoryForProduct(MealProduct)
    }

    private let mealProducts: [MealProduct]
    private let categories: [MealProductCategory]
    private let displayType: MealProductListDisplayType
    private let viewOption: MealProductViewOption
    private let gridSize: MealProductGridSize
    private let onAction: (Action) -> Void

    public init(
        mealProducts: [MealProduct],
        categories: [MealProductCategory] = [],
        displayType: MealProductListDisplayType = .list,
        viewOption: MealProductViewOption = .standard,
        gridSize: MealProductGridSize = .medium,
        onAction: @escaping (Action) -> Void
    ) {
        self.mealProducts = mealProducts
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
            ForEach(mealProducts) { mealProduct in
                MealProductRow(mealProduct, viewOption: viewOption) {
                    onAction(.tapItem(mealProduct))
                }
                .contextMenu { contextMenu(for: mealProduct).tint(Color.onSurfacePrimary) }
            }
        }
    }

    @ViewBuilder
    private var gridView: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)], spacing: 12) {
            ForEach(mealProducts) { mealProduct in
                MealProductCell(mealProduct, viewOption: viewOption) {
                    onAction(.tapItem(mealProduct))
                }
                .contextMenu { contextMenu(for: mealProduct).tint(Color.onSurfacePrimary) }
            }
        }
        .paddingContent()
    }

    @ViewBuilder
    private func contextMenu(for product: MealProduct) -> some View {
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
                    if product.categoryId == nil {
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
                        if product.categoryId == category.id {
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
