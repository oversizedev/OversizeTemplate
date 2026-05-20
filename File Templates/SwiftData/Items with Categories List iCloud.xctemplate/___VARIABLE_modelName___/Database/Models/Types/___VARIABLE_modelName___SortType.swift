// ___FILEHEADER___

import Foundation
import SwiftData

public enum ___VARIABLE_modelName___SortType: String, CaseIterable, Identifiable, Sendable {
    case name, date

    public var id: String {
        rawValue
    }
}

public extension ___VARIABLE_modelName___SortType {
    func sortDescriptor(order: ___VARIABLE_modelName___SortOrder) -> SortDescriptor<___VARIABLE_modelName___Entity> {
        let swiftDataOrder: SortOrder = order == .ascending ? .forward : .reverse

        switch self {
        case .name:
            return SortDescriptor(\___VARIABLE_modelName___Entity.name, order: swiftDataOrder)
        case .date:
            return SortDescriptor(\___VARIABLE_modelName___Entity.date, order: swiftDataOrder)
        }
    }
}

public enum ___VARIABLE_modelName___SortOrder: String, CaseIterable, Sendable, Identifiable {
    case ascending, descending

    public var id: String {
        rawValue
    }
}

public enum ___VARIABLE_modelName___FilterType: String, CaseIterable, Identifiable, Sendable {
    case standard, favorites

    public var id: String {
        rawValue
    }

    public var filterPredicate: Predicate<___VARIABLE_modelName___Entity>? {
        switch self {
        case .standard:
            return nil
        case .favorites:
            return #Predicate { $0.isFavorite }
        }
    }
}
