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
    case name, date, favorite
    
    public var title: String {
        switch self {
        case .name:
            "Name"
        case .date:
            "Date"
        case .favorite:
            "Favorites"
        }
    }
    
    public var id: String {
        rawValue
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

enum ___VARIABLE_modelName___ListKeys {
    public static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
    public static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    public static let sortType = "___VARIABLE_modelName___ListScreen.SortType"
    public static let filterType = "___VARIABLE_modelName___ListScreen.FilterType"
}
