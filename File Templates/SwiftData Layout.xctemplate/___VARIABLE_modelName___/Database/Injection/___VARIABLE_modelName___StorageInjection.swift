// ___FILEHEADER___

import FactoryKit
import SwiftData

public extension Container {
    var ___VARIABLE_modelVariableName___StorageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            ___VARIABLE_modelName___StorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}

// MARK: - Model Container Service

public extension Container {
    var modelContainerService: Factory<ModelContainer> {
        self {
            let schema = Schema([___VARIABLE_modelName___.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }.singleton
    }
}
