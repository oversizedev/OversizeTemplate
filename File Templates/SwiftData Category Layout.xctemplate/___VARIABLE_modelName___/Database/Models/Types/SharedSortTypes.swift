// ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_modelName___ Sort Types

public enum ___VARIABLE_modelName___SortType: String, CaseIterable, Identifiable, Sendable {
    case name
    case date
    case ___VARIABLE_categoryVariableName___

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .name:
            return "Name"
        case .date:
            return "Date"
        case .___VARIABLE_categoryVariableName___:
            return "___VARIABLE_categoryName___"
        }
    }
}

public enum ___VARIABLE_modelName___SortOrder: String, CaseIterable, Identifiable, Sendable {
    case ascending
    case descending

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}

// MARK: - ___VARIABLE_categoryName___ Sort Types

public enum ___VARIABLE_categoryName___SortType: String, CaseIterable, Identifiable, Sendable {
    case name
    case date
    case index

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .name:
            return "Name"
        case .date:
            return "Date"
        case .index:
            return "Order"
        }
    }
}

public enum ___VARIABLE_categoryName___SortOrder: String, CaseIterable, Identifiable, Sendable {
    case ascending
    case descending

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}