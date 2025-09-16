//___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_categoryName___ListViewState: ViewStateProtocol {
    /// App Storage
    public var storage: Storage

    // User Interface
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var filterType: ___VARIABLE_categoryName___FilterType

    // Routing
    public var destination: ___VARIABLE_categoryName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Initialization
    public init(filterType: ___VARIABLE_categoryName___FilterType = .standard) {
        storage = .init()
        self.filterType = filterType
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewState {}

// MARK: - App Storage

public extension ___VARIABLE_categoryName___ListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.displayType)
        public var displayType: ___VARIABLE_categoryName___ListDisplayType = .list

        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.isCompactMode)
        public var isCompactRow: Bool = false

        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.sortType)
        public var sortType: ___VARIABLE_categoryName___SortType = .date

        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.sortOrder)
        public var sortOrder: ___VARIABLE_categoryName___SortOrder = .descending

        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.viewOption)
        public var viewOption: ___VARIABLE_categoryName___ViewOption = .standard

        @DefaultsKey(userDefaultsKey: ___VARIABLE_categoryName___ListKeys.gridSize)
        public var gridSize: ___VARIABLE_categoryName___GridSize = .medium
    }
}