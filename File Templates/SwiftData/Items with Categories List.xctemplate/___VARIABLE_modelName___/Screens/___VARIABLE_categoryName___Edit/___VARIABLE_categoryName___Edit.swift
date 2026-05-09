// ___FILEHEADER___

import Foundation
import OversizeArchitecture

@Module
public enum ___VARIABLE_categoryName___Edit: ModuleProtocol {}

public struct ___VARIABLE_categoryName___EditInput: Sendable {
    public let source: Source?

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

    public init() {
        source = nil
    }

    public var ___VARIABLE_categoryVariableName___Id: UUID? {
        switch source {
        case let .id(id):
            id
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___.id
        case .none:
            nil
        }
    }
}

public struct ___VARIABLE_categoryName___EditOutput: Sendable {
    public let onSave: Callback<___VARIABLE_categoryName___>?

    public init(onSave: Callback<___VARIABLE_categoryName___>? = nil) {
        self.onSave = onSave
    }
}