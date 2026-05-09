// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___ListViewState: ViewStateProtocol {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var state: LoadingState<StateModel> = .idle
    public var searchTerm: String = ""
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?

    public var filterType: ___VARIABLE_categoryName___FilterType

    /// Initialization
    public init(input _: ___VARIABLE_categoryName___List.Input?) {
        filterType = .standard
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewState {
    struct StateModel: Emptyable, Sendable {
        public var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]

        public var isEmpty: Bool {
            ___VARIABLE_categoryPluralVariableName___.isEmpty
        }
    }
}

// MARK: - App Storage

public extension ___VARIABLE_categoryName___ListViewState {
    @ObservableDefaults
    final class Storage: @unchecked Sendable {
        @DefaultsKey(userDefaultsKey: "___VARIABLE_categoryName___ListView.SortType")
        public var sortType: ___VARIABLE_categoryName___SortType = .date

        @DefaultsKey(userDefaultsKey: "___VARIABLE_categoryName___ListView.SortOrder")
        public var sortOrder: ___VARIABLE_categoryName___SortOrder = .descending

        @DefaultsKey(userDefaultsKey: "___VARIABLE_categoryName___ListView.ViewOption")
        public var viewOption: ___VARIABLE_categoryName___ViewOption = .standard
    }
}
