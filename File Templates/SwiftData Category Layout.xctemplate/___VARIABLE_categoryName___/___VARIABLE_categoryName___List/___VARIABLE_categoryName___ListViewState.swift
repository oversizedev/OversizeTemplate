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
public final class ___VARIABLE_categoryName___ListViewState: ViewStateProtocol {
    /// App Storage
    public var storage: Storage

    /// User Interface
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_categoryName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    public var filterType: ___VARIABLE_categoryName___FilterType

    /// Initialization
    public init(filterType: ___VARIABLE_categoryName___FilterType) {
        storage = .init()
        self.filterType = filterType
    }

    public init() {
        storage = .init()
        filterType = .standard
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewState {
    var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___] {
        ___VARIABLE_categoryPluralVariableName___State.successResult ?? []
    }
}

// MARK: - Storage

public extension ___VARIABLE_categoryName___ListViewState {
    @Observable
    @ObservableDefaults
    final class Storage {
        @ObservableDefault("___VARIABLE_categoryName___List.displayType")
        public var displayType: ___VARIABLE_categoryName___ListDisplayType = .list

        @ObservableDefault("___VARIABLE_categoryName___List.sortType")
        public var sortType: ___VARIABLE_categoryName___SortType = .name

        @ObservableDefault("___VARIABLE_categoryName___List.sortOrder")
        public var sortOrder: ___VARIABLE_categoryName___SortOrder = .forward

        @ObservableDefault("___VARIABLE_categoryName___List.isCompactRow")
        public var isCompactRow: Bool = false

        @ObservableDefault("___VARIABLE_categoryName___List.viewOption")
        public var viewOption: ___VARIABLE_categoryName___ViewOption = .standard

        public init() {}
    }
}