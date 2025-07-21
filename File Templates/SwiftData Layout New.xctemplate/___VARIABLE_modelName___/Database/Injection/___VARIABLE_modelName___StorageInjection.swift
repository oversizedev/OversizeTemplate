// ___FILEHEADER___

import FactoryKit

public extension Container {
    var ___VARIABLE_modelVariableName___StorageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            ___VARIABLE_modelName___StorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}
