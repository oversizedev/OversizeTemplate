// ___FILEHEADER___

import Foundation
import SwiftData

public enum ___VARIABLE_categoryName___SortType: String, CaseIterable, Sendable, Identifiable {
    case name, date, popularity

    public var id: String {
        rawValue
    }
}

public extension ___VARIABLE_categoryName___SortType {
    func sortDescriptor(order: ___VARIABLE_categoryName___SortOrder) -> SortDescriptor<___VARIABLE_categoryName___Entity> {
        let swiftDataOrder: SortOrder = order == .ascending ? .forward : .reverse

        switch self {
        case .name:
            return SortDescriptor(\___VARIABLE_categoryName___Entity.name, order: swiftDataOrder)
        case .date:
            return SortDescriptor(\___VARIABLE_categoryName___Entity.date, order: swiftDataOrder)
        case .popularity:
            return SortDescriptor(\___VARIABLE_categoryName___Entity.viewCount, order: swiftDataOrder)
        }
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
