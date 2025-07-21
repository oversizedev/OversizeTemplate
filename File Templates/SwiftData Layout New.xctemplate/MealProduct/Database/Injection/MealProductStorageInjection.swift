// ___FILEHEADER___

import FactoryKit

public extension Container {
    var mealProductStorageService: Factory<MealProductStorageService> {
        self {
            MealProductStorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}
