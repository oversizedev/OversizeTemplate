// ___FILEHEADER___

import Foundation
import Models
import SwiftData

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

public extension ___VARIABLE_categoryName___SortType {
    func sortDescriptor(order: ___VARIABLE_categoryName___SortOrder) -> SortDescriptor<___VARIABLE_categoryName___Entity> {
        let swiftDataOrder: SortOrder = order == .ascending ? .forward : .reverse

        switch self {
        case .name:
            return SortDescriptor(\___VARIABLE_categoryName___Entity.name, order: swiftDataOrder)
        case .date:
            return SortDescriptor(\___VARIABLE_categoryName___Entity.date, order: swiftDataOrder)
        }
    }
}
