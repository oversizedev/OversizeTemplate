// ___FILEHEADER___

import Database
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
public final class MealProductListViewState: Sendable {
    /// App Storage
    public var storage = Storage()

    /// User Interface
    public var mealProductsState: LoadingViewState<[MealProduct]> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var destination: MealProductDestinations?
    public var alert: AppAlert?
    public var isEmptyContent: Bool {
        mealProductsState.result?.isEmpty ?? true
    }

    /// Initialization
    public init() {}
}

// MARK: - User Actions

public extension MealProductListViewState {
    func update(_ handler: @Sendable @MainActor (MealProductListViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
}

// MARK: - App Storage

public extension MealProductListViewState {
    @ObservableDefaults
    class Storage {
        
        @DefaultsKey(userDefaultsKey: MealProductListKeys.displayType)
        public var displayType: MealProductListDisplayType = .list

        @DefaultsKey(userDefaultsKey: MealProductListKeys.isCompactMode)
        public var isCompactRow: Bool = false
    }
}
