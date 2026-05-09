// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture

@Module
public enum ___VARIABLE_modelName___Detail: ModuleProtocol {}

public struct ___VARIABLE_modelName___DetailInput: Sendable {
    public let ___VARIABLE_modelVariableName___Id: String?
    public let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___?

    public init(___VARIABLE_modelVariableName___Id: String? = nil, ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___? = nil) {
        self.___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___Id
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
    }

    public init(id: String) {
        self.___VARIABLE_modelVariableName___Id = id
        self.___VARIABLE_modelVariableName___ = nil
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        self.___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id.uuidString
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
    }
}

public struct ___VARIABLE_modelName___DetailOutput: Sendable {
    public init() {}
}
