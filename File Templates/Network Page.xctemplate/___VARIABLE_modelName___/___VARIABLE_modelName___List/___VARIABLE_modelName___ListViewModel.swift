// ___FILEHEADER___

import Factory
import Observation
import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___StateModel {
    public let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
}

@MainActor
@Observable
public final class ___VARIABLE_modelName___ListViewModel {
    /// Services
    // @ObservationIgnored @Injected(\.service) var service

    /// User Interface
    public var state: LoadingViewState<___VARIABLE_modelName___StateModel> = .idle
    public var searchTerm: String = ""
    public var isSearch: Bool = false

    /// App Storage
    private let storage = Storage()
    public var isCompactRow: Bool {
        didSet { storage.isCompactRow = isCompactRow }
    }

    public var displayType: DisplayType {
        didSet { storage.displayType = displayType }
    }

    /// Initialization
    public init() {
        isCompactRow = storage.isCompactRow
        displayType = storage.displayType
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewModel {
    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_: String, _: String) {}

    func onTapSearch() {
        isSearch.toggle()
    }

    func onTapCompactRow() {
        isCompactRow.toggle()
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData() async {
        let result = await fetch___VARIABLE_modelName___()
        switch result {
        case let .success(___VARIABLE_modelPluralVariableName___):
            state = .result(.init(___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___))
        case let .failure(error):
            state = .error(error)
        }
    }

    private func fetch___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
        .failure(AppError.network(type: .unknown))
    }

    func delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async -> Result<___VARIABLE_modelName___, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}

// MARK: - Supporting Types

extension ___VARIABLE_modelName___ListViewModel {
    public enum DisplayType: String, CaseIterable, Identifiable {
        case list, grid

        public var title: String {
            rawValue.capitalizingFirstLetter()
        }

        public var id: String {
            rawValue
        }

        public var icon: Image {
            switch self {
            case .list:
                Image.GridsAndLayout.List.mini
            case .grid:
                Image.GridsAndLayout.Grid.mini
            }
        }
    }

    enum Keys {
        public static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
        public static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    }

    class Storage {
        @AppStorage(Keys.isCompactMode) public var isCompactRow: Bool = false
        @AppStorage(Keys.displayType) public var displayType: DisplayType =
            .grid
    }
}
