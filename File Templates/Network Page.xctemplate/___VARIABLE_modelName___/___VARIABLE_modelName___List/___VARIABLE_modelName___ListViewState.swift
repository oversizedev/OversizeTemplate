// ___FILEHEADER___

import Factory
import Observation
import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeModels
import SwiftData
import SwiftUI
import ObservableDefaults

@MainActor
@Observable
public final class ___VARIABLE_modelName___ListViewState: Sendable {
    /// App Storage
    public let storage = Storage()

    /// User Interface
    public var ___VARIABLE_modelPluralVariableName___State: LoadingViewState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false

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
        public var displayType: ___VARIABLE_modelName___ListDisplayType = .grid
        
        @DefaultsKey(userDefaultsKey: ___VARIABLE_modelName___ListKeys.isCompactMode)
        public var isCompactRow: Bool = false
        
    }
}
