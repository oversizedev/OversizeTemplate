// ___FILEHEADER___

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
public final class ___VARIABLE_modelName___ListViewState: ViewStateProtocol {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var ___VARIABLE_modelPluralVariableName___State: SearchableLoadingState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    public var filterType: ___VARIABLE_modelName___FilterType

    /// Initialization
    public init(input: ___VARIABLE_modelName___List.Input?) {
        filterType = .standard
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewState {}

// MARK: - App Storage

public extension ___VARIABLE_modelName___ListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.DisplayType")
        public var displayType: ___VARIABLE_modelName___ListDisplayType = .list

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.IsCompactMode")
        public var isCompactRow: Bool = false

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.SortType")
        public var sortType: ___VARIABLE_modelName___SortType = .date

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.SortOrder")
        public var sortOrder: ___VARIABLE_modelName___SortOrder = .descending

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.ViewOption")
        public var viewOption: ___VARIABLE_modelName___ViewOption = .standard

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.GridSize")
        public var gridSize: ___VARIABLE_modelName___GridSize = .medium
    }
}