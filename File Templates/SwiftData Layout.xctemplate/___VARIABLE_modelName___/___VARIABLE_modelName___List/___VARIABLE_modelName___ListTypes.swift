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

public enum ___VARIABLE_modelName___SortType: String, CaseIterable, Identifiable, Sendable {
    case name, date, favorite, viewCount
    
    public var title: String {
        switch self {
        case .name:
            "Name"
        case .date:
            "Date"
        case .favorite:
            "Favorite"
        case .viewCount:
            "View Count"
        }
    }
    
    public var id: String {
        rawValue
    }
    
    public var icon: Image {
        switch self {
        case .name:
            Image.Base.textFormat
        case .date:
            Image.Base.calendar
        case .favorite:
            Image.Base.heart
        case .viewCount:
            Image.Base.eye
        }
    }
}

public enum ___VARIABLE_modelName___FilterType: String, CaseIterable, Identifiable, Sendable {
    case all, favorites, archived, recent
    
    public var title: String {
        switch self {
        case .all:
            "All"
        case .favorites:
            "Favorites"
        case .archived:
            "Archived"
        case .recent:
            "Recent"
        }
    }
    
    public var id: String {
        rawValue
    }
    
    public var icon: Image {
        switch self {
        case .all:
            Image.Base.grid
        case .favorites:
            Image.Base.heart
        case .archived:
            Image.Base.archive
        case .recent:
            Image.Base.clock
        }
    }
}

public enum ___VARIABLE_modelName___ViewOption: String, CaseIterable, Identifiable, Sendable {
    case standard, compact
    
    public var title: String {
        rawValue.capitalizingFirstLetter()
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
    
    public var minWidth: CGFloat {
        switch self {
        case .small:
            150
        case .medium:
            200
        case .large:
            300
        }
    }
}

enum ___VARIABLE_modelName___ListKeys {
    public static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
    public static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    public static let sortType = "___VARIABLE_modelName___ListScreen.SortType"
    public static let sortOrder = "___VARIABLE_modelName___ListScreen.SortOrder"
    public static let filterType = "___VARIABLE_modelName___ListScreen.FilterType"
    public static let gridSize = "___VARIABLE_modelName___ListScreen.GridSize"
    public static let viewOption = "___VARIABLE_modelName___ListScreen.ViewOption"
}
