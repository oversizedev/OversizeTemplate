// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import Foundation
import OversizeArchitecture

@Module
public enum ___VARIABLE_modelName___Edit: ModuleProtocol {}

public struct ___VARIABLE_modelName___EditInput: Sendable {
    public let source: Source?

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

    public init() {
        source = nil
    }

    public var ___VARIABLE_modelVariableName___Id: UUID? {
        switch source {
        case let .id(id):
            id
        case let .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___.id
        case .none:
            nil
        }
    }
}

public struct ___VARIABLE_modelName___EditOutput: Sendable {
    public let onSave: (@Sendable (___VARIABLE_modelName___) -> Void)?

    public init(onSave: (@Sendable (___VARIABLE_modelName___) -> Void)? = nil) {
        self.onSave = onSave
    }
}