// ___FILEHEADER___

import Foundation
import SwiftUI

// MARK: - Filter Types

public enum ___VARIABLE_modelName___ListFilterType: String, CaseIterable, Identifiable, Sendable {
    case standard, archived, favorites

    public var title: String {
        switch self {
        case .standard:
            return "Standard"
        case .archived:
            return "Archived"
        case .favorites:
            return "Favorites"
        }
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .standard:
            Image.Base.list
        case .archived:
            Image.Base.archive
        case .favorites:
            Image.Base.heart
        }
    }
}

// MARK: - Sort Types

public enum ___VARIABLE_modelName___ListSortType: String, CaseIterable, Identifiable, Sendable {
    case name, dateCreated, viewCount, isFavorite

    public var title: String {
        switch self {
        case .name:
            return "Name"
        case .dateCreated:
            return "Date Created"
        case .viewCount:
            return "View Count"
        case .isFavorite:
            return "Favorite"
        }
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .name:
            Image.Base.text
        case .dateCreated:
            Image.Base.calendar
        case .viewCount:
            Image.Base.eye
        case .isFavorite:
            Image.Base.heart
        }
    }
}

// MARK: - Sort Order

public enum ___VARIABLE_modelName___ListSortOrder: String, CaseIterable, Identifiable, Sendable {
    case ascending, descending

    public var title: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .ascending:
            Image.Base.arrowUp
        case .descending:
            Image.Base.arrowDown
        }
    }
}

// MARK: - Display Types

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

// MARK: - Grid Size Options

public enum ___VARIABLE_modelName___ListGridSize: String, CaseIterable, Identifiable, Sendable {
    case small, medium, large

    public var title: String {
        rawValue.capitalizingFirstLetter()
    }

    public var id: String {
        rawValue
    }

    public var columnWidth: CGFloat {
        switch self {
        case .small:
            return 200
        case .medium:
            return 280
        case .large:
            return 360
        }
    }

    public var icon: Image {
        switch self {
        case .small:
            Image.GridsAndLayout.Grid.Small.mini
        case .medium:
            Image.GridsAndLayout.Grid.Medium.mini
        case .large:
            Image.GridsAndLayout.Grid.Large.mini
        }
    }
}

// MARK: - View Options

public enum ___VARIABLE_modelName___ListViewOption: String, CaseIterable, Identifiable, Sendable {
    case showImages, showNotes, showDates, compactMode

    public var title: String {
        switch self {
        case .showImages:
            return "Show Images"
        case .showNotes:
            return "Show Notes"
        case .showDates:
            return "Show Dates"
        case .compactMode:
            return "Compact Mode"
        }
    }

    public var id: String {
        rawValue
    }

    public var icon: Image {
        switch self {
        case .showImages:
            Image.Base.image
        case .showNotes:
            Image.Base.note
        case .showDates:
            Image.Base.calendar
        case .compactMode:
            Image.GridsAndLayout.List.compact
        }
    }
}

// MARK: - Storage Keys

enum ___VARIABLE_modelName___ListKeys {
    public static let filterType = "___VARIABLE_modelName___ListScreen.FilterType"
    public static let sortType = "___VARIABLE_modelName___ListScreen.SortType"
    public static let sortOrder = "___VARIABLE_modelName___ListScreen.SortOrder"
    public static let displayType = "___VARIABLE_modelName___ListScreen.DisplayType"
    public static let gridSize = "___VARIABLE_modelName___ListScreen.GridSize"
    public static let isCompactMode = "___VARIABLE_modelName___ListScreen.IsCompactMode"
    public static let showImages = "___VARIABLE_modelName___ListScreen.ShowImages"
    public static let showNotes = "___VARIABLE_modelName___ListScreen.ShowNotes"
    public static let showDates = "___VARIABLE_modelName___ListScreen.ShowDates"
    public static let lastSearchTerm = "___VARIABLE_modelName___ListScreen.LastSearchTerm"
}
