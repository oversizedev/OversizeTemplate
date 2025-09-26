//
// Copyright © 2025 Alexander Romanov
// MealProductListViewState.swift, created on 10.07.2025
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
public final class MealProductListViewState: ViewStateProtocol {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var mealProductsState: SearchableLoadingState<[MealProduct]> = .idle
    public var categoriesState: LoadingState<[MealProductCategory]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: MealProductDestinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    public var filterType: MealProductFilterType

    /// Initialization
    public init(input: MealProductList.Input?) {
        filterType = .standard
    }
}

// MARK: - App Storage

public extension MealProductListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: "MealProductListView.DisplayType")
        public var displayType: MealProductListDisplayType = .list

        @DefaultsKey(userDefaultsKey: "MealProductListView.IsCompactMode")
        public var isCompactRow: Bool = false

        @DefaultsKey(userDefaultsKey: "MealProductListView.SortType")
        public var sortType: MealProductSortType = .date

        @DefaultsKey(userDefaultsKey: "MealProductListView.SortOrder")
        public var sortOrder: MealProductSortOrder = .descending

        @DefaultsKey(userDefaultsKey: "MealProductListView.ViewOption")
        public var viewOption: MealProductViewOption = .standard

        @DefaultsKey(userDefaultsKey: "MealProductListView.GridSize")
        public var gridSize: MealProductGridSize = .medium
    }
}
