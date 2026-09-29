// ___FILEHEADER___

import FactoryKit
import OversizeCore

public extension Container {
    var ___VARIABLE_modelVariableName___Service: Factory<___VARIABLE_modelName___Service> {
        self {
            Log.info("Creating ___VARIABLE_modelName___Service instance")
            return ___VARIABLE_modelName___Service()
        }.cached
    }

    var ___VARIABLE_categoryVariableName___Service: Factory<___VARIABLE_categoryName___Service> {
        self {
            Log.info("Creating ___VARIABLE_categoryName___Service instance")
            return ___VARIABLE_categoryName___Service()
        }.cached
    }
}
