// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Foundation

enum ___VARIABLE_modelName___TestData {
    @discardableResult
    static func make___VARIABLE_modelName___(
        _ name: String,
        note: String? = nil,
        isFavorite: Bool = false,
        categoryId: UUID? = nil
    ) async throws -> ___VARIABLE_modelName___ {
        let storage = Container.shared.___VARIABLE_modelVariableName___StorageService()
        let ___VARIABLE_modelVariableName___ = try await storage.save(name: name, color: .blue, note: note, ___VARIABLE_categoryVariableName___Id: categoryId)
        return isFavorite ? try await storage.toggleFavorite(___VARIABLE_modelVariableName___) : ___VARIABLE_modelVariableName___
    }

    @discardableResult
    static func make___VARIABLE_categoryName___(_ name: String, isFavorite: Bool = false) async throws -> ___VARIABLE_categoryName___ {
        let storage = Container.shared.___VARIABLE_categoryVariableName___StorageService()
        let category = try await storage.save(name: name, color: .red)
        return isFavorite ? try await storage.toggleFavorite(category) : category
    }
}
