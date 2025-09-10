// ___FILEHEADER___

import Foundation

public enum ___VARIABLE_categoryName___ListTypes {
    public enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapCreate___VARIABLE_categoryName___
        case onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onToggleFavorite(___VARIABLE_categoryName___)
        case onToggleArchive(___VARIABLE_categoryName___)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onChangeFilterType(___VARIABLE_categoryName___FilterType)
        case onChangeSortType(___VARIABLE_categoryName___SortType)
        case onChangeSortOrder(___VARIABLE_categoryName___SortOrder)
        case onChangeViewOption(___VARIABLE_categoryName___ViewOption)
    }
}

public enum ___VARIABLE_categoryName___ListDisplayType: String, CaseIterable, Identifiable {
    case list
    case grid

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .list: "List"
        case .grid: "Grid"
        }
    }

    public var icon: Icon {
        switch self {
        case .list: .Base.ListDashes
        case .grid: .Base.SquareGrid.d2x2
        }
    }
}

public enum ___VARIABLE_categoryName___GridSize: String, CaseIterable, Identifiable {
    case small
    case medium
    case large

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .small: "Small"
        case .medium: "Medium"
        case .large: "Large"
        }
    }

    public var minimumWidth: CGFloat {
        switch self {
        case .small: 100
        case .medium: 140
        case .large: 200
        }
    }
}

public enum ___VARIABLE_categoryName___ViewOption: String, CaseIterable, Identifiable {
    case withoutNote
    case withNote

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .withoutNote: "Without Note"
        case .withNote: "With Note"
        }
    }
}

public enum ___VARIABLE_categoryName___FilterType: String, CaseIterable, Identifiable {
    case standard
    case favorites
    case archived

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .standard: "All"
        case .favorites: "Favorites"
        case .archived: "Archive"
        }
    }

    public var icon: Icon {
        switch self {
        case .standard: .Base.Square.grid2x2
        case .favorites: .Base.Star
        case .archived: .Delivery.Delivery
        }
    }

    public var emptyStateTitle: String {
        switch self {
        case .standard: "No ___VARIABLE_categoryPluralVariableName___ Yet"
        case .favorites: "No Favorite ___VARIABLE_categoryPluralVariableName___"
        case .archived: "No Archived ___VARIABLE_categoryPluralVariableName___"
        }
    }

    public var emptyStateSubtitle: String {
        switch self {
        case .standard: "Create your first ___VARIABLE_categoryVariableName___ to get started"
        case .favorites: "Mark ___VARIABLE_categoryPluralVariableName___ as favorites to see them here"
        case .archived: "Archived ___VARIABLE_categoryPluralVariableName___ will appear here"
        }
    }

    public var emptyStateImage: Icon {
        switch self {
        case .standard: .Objects.folder
        case .favorites: .Base.Star
        case .archived: .Delivery.Delivery
        }
    }
}