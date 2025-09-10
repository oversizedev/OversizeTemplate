// ___FILEHEADER___

import FactoryKit
import OversizeCore

public extension Container {
    var ___VARIABLE_modelVariableName___StorageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            logInfo("Creating ___VARIABLE_modelName___StorageService instance")
            return ___VARIABLE_modelName___StorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}
