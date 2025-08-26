// ___FILEHEADER___

import SwiftData
import Foundation

public enum ___VARIABLE_modelName___SortType: String, CaseIterable, Sendable, Identifiable {
    case name, date, popularity

    public var id: String {
        rawValue
    }
}

public extension ___VARIABLE_modelName___SortType {
    func sortDescriptor(order: ___VARIABLE_modelName___SortOrder) -> SortDescriptor<___VARIABLE_modelName___> {
        let swiftDataOrder: SortOrder = order == .ascending ? .forward : .reverse
        
        switch self {
        case .name:
            return SortDescriptor(\___VARIABLE_modelName___.name, order: swiftDataOrder)
        case .date:
            return SortDescriptor(\___VARIABLE_modelName___.date, order: swiftDataOrder)
        case .popularity:
            return SortDescriptor(\___VARIABLE_modelName___.viewCount, order: swiftDataOrder)
        }
    }
}

public enum ___VARIABLE_modelName___SortOrder: String, CaseIterable, Sendable, Identifiable {
    case ascending, descending

    public var id: String {
        rawValue
    }
}
