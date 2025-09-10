// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___ListViewState {
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var filterType: ___VARIABLE_categoryName___FilterType
    public var hud: HUDState = .none
    public var alert: AlertState = .none
    public var destination: ___VARIABLE_modelName___Destinations?
    public var storage: ___VARIABLE_categoryName___ListStorageState

    public init(
        filterType: ___VARIABLE_categoryName___FilterType = .standard,
        storage: ___VARIABLE_categoryName___ListStorageState = .init()
    ) {
        self.filterType = filterType
        self.storage = storage
    }
}

@Observable
public final class ___VARIABLE_categoryName___ListStorageState {
    @ObservationIgnored @AppStorage("___VARIABLE_categoryName___ListDisplayType") public var displayType: ___VARIABLE_categoryName___ListDisplayType = .list
    @ObservationIgnored @AppStorage("___VARIABLE_categoryName___GridSize") public var gridSize: ___VARIABLE_categoryName___GridSize = .medium
    @ObservationIgnored @AppStorage("___VARIABLE_categoryName___SortType") public var sortType: ___VARIABLE_categoryName___SortType = .date
    @ObservationIgnored @AppStorage("___VARIABLE_categoryName___SortOrder") public var sortOrder: ___VARIABLE_categoryName___SortOrder = .reverse
    @ObservationIgnored @AppStorage("___VARIABLE_categoryName___ViewOption") public var viewOption: ___VARIABLE_categoryName___ViewOption = .withoutNote

    public init() {}
}