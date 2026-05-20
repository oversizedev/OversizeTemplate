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

// MARK: - Filter Type Extensions

public extension ___VARIABLE_categoryName___FilterType {
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
