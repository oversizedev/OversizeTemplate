// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_modelName___ListViewState: ViewStateProtocol {
    /// App Storage
    public var storage: Storage

    /// User Interface
    public var ___VARIABLE_modelPluralVariableName___State: LoadingState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    public var filterType: ___VARIABLE_modelName___FilterType

    /// Initialization
    public init(filterType: ___VARIABLE_modelName___FilterType) {
        storage = .init()
        self.filterType = filterType
    }

    public init() {
        storage = .init()
        filterType = .standard
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewState {}

// MARK: - App Storage

public extension ___VARIABLE_modelName___ListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.displayType)
        public var displayType: ___VARIABLE_modelName___ListDisplayType = .list

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.isCompactMode)
        public var isCompactRow: Bool = false

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.sortType)
        public var sortType: ___VARIABLE_modelName___SortType = .date

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.sortOrder)
        public var sortOrder: ___VARIABLE_modelName___SortOrder = .descending

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.viewOption)
        public var viewOption: ___VARIABLE_modelName___ViewOption = .standard

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.gridSize)
        public var gridSize: ___VARIABLE_modelName___GridSize = .medium
    }
}
