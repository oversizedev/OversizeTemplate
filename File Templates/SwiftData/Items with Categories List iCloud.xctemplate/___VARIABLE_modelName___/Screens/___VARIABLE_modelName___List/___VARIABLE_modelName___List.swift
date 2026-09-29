// ___FILEHEADER___

import Foundation
import Models
import OversizeArchitecture
import OversizeResources
import SwiftUI

// MARK: - Module Definition

@Module
public enum ___VARIABLE_modelName___List: ModuleProtocol {}

public struct ___VARIABLE_modelName___ListInput: Sendable {
    public init() {}
}

public struct ___VARIABLE_modelName___ListOutput: Sendable {
    public init() {}
}

public struct ___VARIABLE_modelName___ListQuery: Equatable, Sendable {
    public let searchTerm: String
    public let filterType: ___VARIABLE_modelName___FilterType
    public let sortType: ___VARIABLE_modelName___SortType
    public let sortOrder: ___VARIABLE_modelName___SortOrder

    @MainActor
    init(_ viewState: ___VARIABLE_modelName___ListViewState) {
        searchTerm = viewState.searchTerm
        filterType = viewState.filterType
        sortType = viewState.storage.sortType
        sortOrder = viewState.storage.sortOrder
    }
}

public enum ___VARIABLE_modelName___ViewOption: String, CaseIterable, Identifiable, Sendable {
    case standard, compact

    public var title: String {
        switch self {
        case .standard:
            "Standard"
        case .compact:
            "Compact"
        }
    }

    public var id: String {
        rawValue
    }
}

// MARK: - Filter Type Extensions

public extension ___VARIABLE_modelName___FilterType {
    var title: String {
        switch self {
        case .standard:
            "All items"
        case .favorites:
            "Favorites"
        }
    }

    var icon: Image {
        switch self {
        case .standard:
            Image.GridsAndLayout.Grid.mini
        case .favorites:
            Image.Base.Star.mini
        }
    }

    var emptyStateImage: Image? {
        switch self {
        case .standard:
            Illustration.Objects.box
        case .favorites:
            Illustration.Objects.star
        }
    }

    var emptyStateTitle: String {
        switch self {
        case .standard:
            "Your list is empty"
        case .favorites:
            "No favorite items yet"
        }
    }

    var emptyStateSubtitle: String? {
        switch self {
        case .standard:
            "Add your first item to get started"
        case .favorites:
            "Mark items as favorites to see them here"
        }
    }
}

// MARK: - Sort Type Extensions

public extension ___VARIABLE_modelName___SortType {
    var title: String {
        switch self {
        case .name:
            "Name"
        case .date:
            "Date"
        }
    }
}

public extension ___VARIABLE_modelName___SortOrder {
    var title: String {
        switch self {
        case .ascending:
            "Ascending"
        case .descending:
            "Descending"
        }
    }
}
