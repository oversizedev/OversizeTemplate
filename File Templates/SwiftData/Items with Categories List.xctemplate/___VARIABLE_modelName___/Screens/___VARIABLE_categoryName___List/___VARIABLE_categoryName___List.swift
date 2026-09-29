// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeArchitecture
import OversizeResources
import SwiftUI

// MARK: - Module Definition

@Module
public enum ___VARIABLE_categoryName___List: ModuleProtocol {}

public struct ___VARIABLE_categoryName___ListInput: Sendable {
    public init() {}
}

public struct ___VARIABLE_categoryName___ListOutput: Sendable {
    public init() {}
}

public struct ___VARIABLE_categoryName___ListQuery: Equatable, Sendable {
    public let searchTerm: String
    public let filterType: ___VARIABLE_categoryName___FilterType
    public let sortType: ___VARIABLE_categoryName___SortType
    public let sortOrder: ___VARIABLE_categoryName___SortOrder

    @MainActor
    init(_ viewState: ___VARIABLE_categoryName___ListViewState) {
        searchTerm = viewState.searchTerm
        filterType = viewState.filterType
        sortType = viewState.storage.sortType
        sortOrder = viewState.storage.sortOrder
    }
}

public enum ___VARIABLE_categoryName___ViewOption: String, CaseIterable, Identifiable, Sendable {
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

// MARK: - Display Extensions

public extension ___VARIABLE_categoryName___ {
    static let defaultEmoji = "🍏"

    var displayEmoji: String {
        emoji ?? Self.defaultEmoji
    }
}

// MARK: - Filter Type Extensions

public extension ___VARIABLE_categoryName___FilterType {
    var title: String {
        switch self {
        case .standard:
            "All categories"
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
            "No categories yet"
        case .favorites:
            "No favorite categories yet"
        }
    }

    var emptyStateSubtitle: String? {
        switch self {
        case .standard:
            "Add your first category to get started"
        case .favorites:
            "Mark categories as favorites to see them here"
        }
    }
}

// MARK: - Sort Type Extensions

public extension ___VARIABLE_categoryName___SortType {
    var title: String {
        switch self {
        case .name:
            "Name"
        case .date:
            "Date"
        }
    }
}

public extension ___VARIABLE_categoryName___SortOrder {
    var title: String {
        switch self {
        case .ascending:
            "Ascending"
        case .descending:
            "Descending"
        }
    }
}
