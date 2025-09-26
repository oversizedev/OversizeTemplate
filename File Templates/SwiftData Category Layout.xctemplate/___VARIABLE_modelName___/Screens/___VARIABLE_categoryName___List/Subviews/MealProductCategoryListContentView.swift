//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryListContentView.swift, created on 29.07.2025
//

import Database
import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

/// Reusable content view component for displaying MealProductCategory lists
public struct MealProductCategoryListContentView: View {
    public enum Action: Sendable {
        case onTapItem(MealProductCategory)
        case onTapEditCategory(MealProductCategory)
        case onTapToggleFavorite(MealProductCategory)
        case onTapDuplicateCategory(MealProductCategory)
        case onTapDeleteCategory(MealProductCategory)
    }

    private let mealProductCategories: [MealProductCategory]
    private let displayType: MealProductCategoryListDisplayType
    private let viewOption: MealProductCategoryViewOption
    private let gridSize: MealProductCategoryGridSize
    private let onAction: (Action) -> Void

    public init(
        mealProductCategories: [MealProductCategory],
        displayType: MealProductCategoryListDisplayType = .list,
        viewOption: MealProductCategoryViewOption = .standard,
        gridSize: MealProductCategoryGridSize = .medium,
        onAction: @escaping (Action) -> Void
    ) {
        self.mealProductCategories = mealProductCategories
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
            ForEach(mealProductCategories) { mealProductCategory in
                MealProductCategoryRow(mealProductCategory, viewOption: viewOption) {
                    onAction(.onTapItem(mealProductCategory))
                }
                .contextMenu { contextMenu(for: mealProductCategory) }
            }
        }
    }

    @ViewBuilder
    private var gridView: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: gridSize.minimumWidth), spacing: 12)], spacing: 12) {
            ForEach(mealProductCategories) { mealProductCategory in
                MealProductCategoryCell(mealProductCategory, viewOption: viewOption) {
                    onAction(.onTapItem(mealProductCategory))
                }
                .contextMenu { contextMenu(for: mealProductCategory) }
            }
        }
        .paddingContent()
    }

    @ViewBuilder
    private func contextMenu(for category: MealProductCategory) -> some View {
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
