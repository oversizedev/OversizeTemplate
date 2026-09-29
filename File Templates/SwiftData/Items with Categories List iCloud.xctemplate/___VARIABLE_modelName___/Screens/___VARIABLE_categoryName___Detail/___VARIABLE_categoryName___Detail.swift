// ___FILEHEADER___

import Foundation
import Models
import OversizeArchitecture

@Module
public enum ___VARIABLE_categoryName___Detail: ModuleProtocol {}

public struct ___VARIABLE_categoryName___DetailInput: Sendable {
    public let source: Source

    public enum Source: Sendable {
        case id(UUID)
        case ___VARIABLE_categoryVariableName___(___VARIABLE_categoryName___)
    }

    public init(id: UUID) {
        source = .id(id)
    }

    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        source = .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___)
    }

    public var ___VARIABLE_categoryVariableName___Id: UUID {
        switch source {
        case let .id(id):
            id
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___.id
        }
    }
}

public struct ___VARIABLE_categoryName___DetailOutput: Sendable {
    public let onEdit: Callback<___VARIABLE_categoryName___>?
    public let onDelete: Callback<___VARIABLE_categoryName___>?

    public init(
        onEdit: Callback<___VARIABLE_categoryName___>? = nil,
        onDelete: Callback<___VARIABLE_categoryName___>? = nil
    ) {
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
}
