// ___FILEHEADER___

import SwiftData
import Foundation

public enum ___VARIABLE_categoryName___SortType: String, CaseIterable, Sendable, Identifiable {
    case name, sortOrder, ___VARIABLE_modelVariableName___Count

    public var id: String {
        rawValue
    }
}

public extension ___VARIABLE_categoryName___SortType {
    func sortDescriptor(order: ___VARIABLE_categoryName___SortOrder) -> SortDescriptor<___VARIABLE_categoryName___> {
        let swiftDataOrder: SortOrder = order == .ascending ? .forward : .reverse
        
        switch self {
        case .name:
            return SortDescriptor(\___VARIABLE_categoryName___.name, order: swiftDataOrder)
        case .sortOrder:
            return SortDescriptor(\___VARIABLE_categoryName___.sortOrder, order: swiftDataOrder)
        case .___VARIABLE_modelVariableName___Count:
            return SortDescriptor(\___VARIABLE_categoryName___.___VARIABLE_modelPluralVariableName___.count, order: swiftDataOrder)
        }
    }
}

public enum ___VARIABLE_categoryName___SortOrder: String, CaseIterable, Sendable, Identifiable {
    case ascending, descending

    public var id: String {
        rawValue
    }
}