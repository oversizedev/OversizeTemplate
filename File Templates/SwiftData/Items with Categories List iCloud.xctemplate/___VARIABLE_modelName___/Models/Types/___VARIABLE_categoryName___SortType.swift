// ___FILEHEADER___

import Foundation

public enum ___VARIABLE_categoryName___SortType: String, CaseIterable, Identifiable, Sendable {
    case name, date

    public var id: String {
        rawValue
    }
}

public enum ___VARIABLE_categoryName___SortOrder: String, CaseIterable, Sendable, Identifiable {
    case ascending, descending

    public var id: String {
        rawValue
    }
}

public enum ___VARIABLE_categoryName___FilterType: String, CaseIterable, Identifiable, Sendable {
    case standard, favorites

    public var id: String {
        rawValue
    }
}
