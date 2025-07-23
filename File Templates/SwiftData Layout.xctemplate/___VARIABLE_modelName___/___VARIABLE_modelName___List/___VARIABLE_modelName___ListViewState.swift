// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import SwiftData
import SwiftUI
import OversizeNavigation

@MainActor
@Observable
public final class ___VARIABLE_modelName___ListViewState: Sendable {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var ___VARIABLE_modelPluralVariableName___State: LoadingViewState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var isEmptyContent: Bool {
        ___VARIABLE_modelPluralVariableName___State.result?.isEmpty ?? true
    }

    /// Initialization
    public init() {}
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewState {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_modelName___ListViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
}

// MARK: - App Storage

public extension ___VARIABLE_modelName___ListViewState {
    @ObservableDefaults
    class Storage {
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.displayType)
        public var displayType: ___VARIABLE_modelName___ListDisplayType = .list

        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.isCompactMode)
        public var isCompactRow: Bool = false
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.sortType)
        public var sortType: ___VARIABLE_modelName___SortType = .date
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.filterType)
        public var filterType: ___VARIABLE_modelName___FilterType = .all
    }
}
