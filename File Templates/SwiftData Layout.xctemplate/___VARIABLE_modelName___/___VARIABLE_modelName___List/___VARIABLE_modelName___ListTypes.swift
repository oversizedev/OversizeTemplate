// ___FILEHEADER___

import Foundation
import SwiftUI

public enum ___VARIABLE_modelName___ListDisplayType: String, CaseIterable, Identifiable, Sendable {
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

public enum ___VARIABLE_modelName___FilterType: String, CaseIterable, Identifiable, Sendable {
    case all, favorites, archived

    public var title: String {
        switch self {
        case .all:
            "All"
        case .favorites:
            "Favorites"
        case .archived:
            "Archived"
        }
    }

    public var id: String {
        rawValue
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
        rawValue.capitalizingFirstLetter()
    }

    public var id: String {
        rawValue
    }

    public var columnCount: Int {
        switch self {
        case .small:
            4
        case .medium:
            3
        case .large:
            2
        }
    }
}

enum ___VARIABLE_modelName___ListKeys {
    public static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
    public static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    public static let filterType = "___VARIABLE_modelName___ListScreen.FilterType"
    public static let viewOption = "___VARIABLE_modelName___ListScreen.ViewOption"
    public static let gridSize = "___VARIABLE_modelName___ListScreen.GridSize"
}
