// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___ListViewState: ViewStateProtocol {
    // MARK: - App Storage

    public var storage = Storage()

    // MARK: - User Interface

    public var state: LoadingState<StateModel> = .idle
    public var searchTerm: String = ""
    public var filterType: ___VARIABLE_modelName___FilterType = .standard

    // MARK: - Routing

    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    // MARK: - Initialization

    public init(input: ___VARIABLE_modelName___List.Input?) {
        filterType = input?.filterType ?? .standard
    }
}

// MARK: - State Model

public extension ___VARIABLE_modelName___ListViewState {
    struct StateModel: Emptyable, Sendable {
        public var ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
        public var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]

        public var isEmpty: Bool {
            ___VARIABLE_modelPluralVariableName___.isEmpty
        }
    }
}

// MARK: - App Storage

public extension ___VARIABLE_modelName___ListViewState {
    @MainActor
    @ObservableDefaults(ignoreExternalChanges: true)
    final class Storage: Sendable {
        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.SortType")
        public var sortType: ___VARIABLE_modelName___SortType = .date

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.SortOrder")
        public var sortOrder: ___VARIABLE_modelName___SortOrder = .descending

        @DefaultsKey(userDefaultsKey: "___VARIABLE_modelName___ListView.ViewOption")
        public var viewOption: ___VARIABLE_modelName___ViewOption = .standard
    }
}
