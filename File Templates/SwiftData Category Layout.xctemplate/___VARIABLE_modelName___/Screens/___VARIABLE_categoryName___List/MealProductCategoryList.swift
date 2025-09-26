//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryList.swift, created on 19.09.2025
//

import Database
import Foundation
import OversizeArchitecture
import OversizeResources
import SwiftUI

// MARK: - Module Definition

@Module
public enum MealProductCategoryList: ModuleProtocol {}

public struct MealProductCategoryListInput: Sendable {
    public init() {}
}

public struct MealProductCategoryListOutput: Sendable {
    public init() {}
}

// MARK: - Display Types

public enum MealProductCategoryListDisplayType: String, CaseIterable, Identifiable, Sendable {
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

public enum MealProductCategoryViewOption: String, CaseIterable, Identifiable, Sendable {
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

public enum MealProductCategoryGridSize: String, CaseIterable, Identifiable, Sendable {
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

public extension MealProductCategoryFilterType {
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

public extension MealProductCategorySortType {
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

public extension MealProductCategorySortOrder {
    var title: String {
        switch self {
        case .ascending:
            "Ascending"
        case .descending:
            "Descending"
        }
    }
}
