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

// MARK: - Service Registration

public extension Container {
    func register___VARIABLE_modelName___Services() {
        // Register all ___VARIABLE_modelName___ related services
        logInfo("Registering ___VARIABLE_modelName___ services")
        
        // Storage service is automatically registered via the factory above
        // Add any additional service registrations here
    }
}

// MARK: - Testing Support

#if DEBUG
public extension Container {
    var mock___VARIABLE_modelName___StorageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            // Create in-memory container for testing
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try! ModelContainer(for: ___VARIABLE_modelName___.self, configurations: config)
            return ___VARIABLE_modelName___StorageService(modelContainer: container)
        }.singleton
    }
}
#endif
