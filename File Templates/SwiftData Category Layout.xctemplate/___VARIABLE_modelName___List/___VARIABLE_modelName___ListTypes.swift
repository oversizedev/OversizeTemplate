//___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeResources
import SwiftUI

public enum ___VARIABLE_modelName___FilterType: String, CaseIterable, Identifiable, Sendable {
    case standard, archived, favorites, ___VARIABLE_categoryVariableName___

    public var title: String {
        switch self {
        case .standard:
            "All items"
        case .archived:
            "Archived"
        case .favorites:
            "Favorites"
        case .___VARIABLE_categoryVariableName___:
            "By ___VARIABLE_categoryName___"
        }
    }

    public var icon: Image {
        switch self {
        case .standard:
            Image.GridsAndLayout.Grid.mini
        case .archived:
            Image.Delivery.Delivery.mini
        case .favorites:
            Image.Base.Star.mini
        case .___VARIABLE_categoryVariableName___:
            Image.Editor.OrganizeList.mini
        }
    }

    public var emptyStateImage: Image? {
        switch self {
        case .standard:
            Illustration.Objects.box
        case .archived:
            Illustration.Objects.Arhive.medium
        case .favorites:
            Illustration.Objects.star
        case .___VARIABLE_categoryVariableName___:
            Illustration.Objects.folder
        }
    }

    public var emptyStateTitle: String {
        switch self {
        case .standard:
            "Your list is empty"
        case .archived:
            "No archived items yet"
        case .favorites:
            "No favorite items yet"
        case .___VARIABLE_categoryVariableName___:
            "No items in this ___VARIABLE_categoryVariableName___"
        }
    }

    public var emptyStateSubtitle: String? {
        switch self {
        case .standard:
            "Add your first item to get started"
        case .archived:
            "Archive items to see them here"
        case .favorites:
            "Mark items as favorites to see them here"
        case .___VARIABLE_categoryVariableName___:
            "Add items to this ___VARIABLE_categoryVariableName___ to see them here"
        }
    }

    public var id: String {
        rawValue
    }
}

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

public enum GridSize: String, CaseIterable, Identifiable, Sendable {
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

enum ___VARIABLE_modelName___ListKeys {
    static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
    static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    static let sortType = "___VARIABLE_modelName___ListScreen.SortType"
    static let sortOrder = "___VARIABLE_modelName___ListScreen.SortOrder"
    static let filterType = "___VARIABLE_modelName___ListScreen.FilterType"
    static let viewOption = "___VARIABLE_modelName___ListScreen.ViewOption"
    static let gridSize = "___VARIABLE_modelName___ListScreen.GridSize"
}
