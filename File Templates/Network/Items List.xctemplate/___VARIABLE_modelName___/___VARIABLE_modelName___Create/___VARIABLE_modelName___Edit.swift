// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture

@Module
public enum ___VARIABLE_modelName___Edit: ModuleProtocol {}

public struct ___VARIABLE_modelName___EditInput: Sendable {
    public let mode: ___VARIABLE_modelName___EditViewState.EditMode

    public init(mode: ___VARIABLE_modelName___EditViewState.EditMode = .create) {
        self.mode = mode
    }

    public static var create: ___VARIABLE_modelName___EditInput {
        .init(mode: .create)
    }

    public static func edit(id: String) -> ___VARIABLE_modelName___EditInput {
        .init(mode: .editId(id))
    }

    public static func edit(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> ___VARIABLE_modelName___EditInput {
        .init(mode: .edit(___VARIABLE_modelVariableName___))
    }
}

public struct ___VARIABLE_modelName___EditOutput: Sendable {
    public init() {}
}
