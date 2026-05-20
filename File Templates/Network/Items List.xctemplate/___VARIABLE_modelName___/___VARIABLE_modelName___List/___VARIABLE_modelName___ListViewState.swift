// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___ListViewState: ViewStateProtocol, Sendable {
    public typealias Module = ___VARIABLE_modelName___List

    public var storage = Storage()

    public var ___VARIABLE_modelPluralVariableName___State: LoadingState<[___VARIABLE_modelName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var isEmptyContent: Bool {
        ___VARIABLE_modelPluralVariableName___State.result?.isEmpty ?? true
    }

    public required init(input: Module.Input?) {
        _ = input
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
    }
}
