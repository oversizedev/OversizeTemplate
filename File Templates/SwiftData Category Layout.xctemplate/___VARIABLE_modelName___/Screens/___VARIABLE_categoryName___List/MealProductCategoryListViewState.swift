//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryListViewState.swift, created on 27.07.2025
//

import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class MealProductCategoryListViewState: ViewStateProtocol {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var mealProductCategoriesState: SearchableLoadingState<[MealProductCategory]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: MealProductDestinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    public var filterType: MealProductCategoryFilterType

    /// Initialization
    public init(input: MealProductCategoryList.Input?) {
        filterType = .standard
    }
}

// MARK: - User Actions

public extension MealProductCategoryListViewState {}

// MARK: - App Storage

public extension MealProductCategoryListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.DisplayType")
        public var displayType: MealProductCategoryListDisplayType = .list

        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.IsCompactMode")
        public var isCompactRow: Bool = false

        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.SortType")
        public var sortType: MealProductCategorySortType = .date

        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.SortOrder")
        public var sortOrder: MealProductCategorySortOrder = .descending

        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.ViewOption")
        public var viewOption: MealProductCategoryViewOption = .standard

        @DefaultsKey(userDefaultsKey: "MealProductCategoryListView.GridSize")
        public var gridSize: MealProductCategoryGridSize = .medium
    }
}
