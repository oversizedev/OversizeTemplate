// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeArchitecture

@Module
public enum ___VARIABLE_modelName___Detail: ModuleProtocol {}

public struct ___VARIABLE_modelName___DetailInput: Sendable {
    public let source: Source

    public enum Source: Sendable {
        case id(UUID)
        case ___VARIABLE_modelVariableName___(___VARIABLE_modelName___)
    }

    public init(id: UUID) {
        source = .id(id)
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        source = .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___)
    }

    public var ___VARIABLE_modelVariableName___Id: UUID {
        switch source {
        case let .id(id):
            id
        case let .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___.id
        }
    }
}

public struct ___VARIABLE_modelName___DetailOutput: Sendable {
    public let onEdit: Callback<___VARIABLE_modelName___>?
    public let onDelete: Callback<___VARIABLE_modelName___>?

    public init(
        onEdit: Callback<___VARIABLE_modelName___>? = nil,
        onDelete: Callback<___VARIABLE_modelName___>? = nil
    ) {
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
}
