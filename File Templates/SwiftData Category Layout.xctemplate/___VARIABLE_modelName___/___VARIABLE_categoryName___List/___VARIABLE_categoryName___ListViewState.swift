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
    // User Interface
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var filterType: ___VARIABLE_categoryName___FilterType = .standard
    public var storage: ___VARIABLE_categoryName___ListStorageType = .init()

    // Routing
    public var destination: ___VARIABLE_categoryName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Initialization
    public init(filterType: ___VARIABLE_categoryName___FilterType = .standard) {
        self.filterType = filterType
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewState {}