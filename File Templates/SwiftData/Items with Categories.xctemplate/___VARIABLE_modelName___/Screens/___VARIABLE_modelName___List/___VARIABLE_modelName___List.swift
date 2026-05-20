// ___FILEHEADER___

import Database
import Foundation
import OversizeArchitecture
import OversizeResources
import SwiftUI

// MARK: - Module Definition

@Module
public enum ___VARIABLE_modelName___List: ModuleProtocol {}

public struct ___VARIABLE_modelName___ListInput: Sendable {
    public let categoryId: UUID?

    public init(categoryId: UUID? = nil) {
        self.categoryId = categoryId
    }
}

public struct ___VARIABLE_modelName___ListOutput: Sendable {
    public let onProductSelected: (@Sendable (___VARIABLE_modelName___) -> Void)?

    public init(onProductSelected: (@Sendable (___VARIABLE_modelName___) -> Void)? = nil) {
        self.onProductSelected = onProductSelected
    }
}

// MARK: - Display Types

public enum ___VARIABLE_modelName___ListDisplayType: String, CaseIterable, Identifiable, Sendable {
    case grid, list

    public var title: String {
        rawValue.capitalizingFirstLetter()
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .list:
            Image.Editor.BulletedList.mini
        case .grid:
            Image.GridsAndLayout.Grid.mini
        }
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

public enum ___VARIABLE_modelName___GridSize: String, CaseIterable, Identifiable, Sendable {
    case small, medium, large

    public var title: String {
        switch self {
        case .small:
            "Small"
        case .medium:
            "Medium"
        case .large:
            "Large"
        }
    }

    public var minimumWidth: CGFloat {
        switch self {
        case .small:
            150
        case .medium:
            320
        case .large:
            480
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
        case .popularity:
            "Popularity"
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

