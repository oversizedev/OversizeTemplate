// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeArchitecture

@Module
public enum ___VARIABLE_modelName___Edit: ModuleProtocol {}

public struct ___VARIABLE_modelName___EditInput: Sendable {
    public let source: Source?
    public let ___VARIABLE_categoryVariableName___Id: UUID?

    public enum Source: Sendable {
        case id(UUID)
        case ___VARIABLE_modelVariableName___(___VARIABLE_modelName___)
    }

    public init(id: UUID) {
        source = .id(id)
        ___VARIABLE_categoryVariableName___Id = nil
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        source = .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___)
        ___VARIABLE_categoryVariableName___Id = nil
    }

    public init(___VARIABLE_categoryVariableName___Id: UUID? = nil) {
        source = nil
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id
    }
}

public struct ___VARIABLE_modelName___EditOutput: Sendable {
    public let onSave: Callback<___VARIABLE_modelName___>?

    public init(onSave: Callback<___VARIABLE_modelName___>? = nil) {
        self.onSave = onSave
    }
}
