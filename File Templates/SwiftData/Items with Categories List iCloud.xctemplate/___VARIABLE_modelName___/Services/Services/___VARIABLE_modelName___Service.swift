// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Foundation
import Models
import SwiftUI

public actor ___VARIABLE_modelName___Service {
    @LazyInjected(\.___VARIABLE_modelVariableName___StorageService) private var storage: ___VARIABLE_modelName___StorageService

    public init() {}

    public func save(
        name: String,
        color: Color,
        date: Date = Date(),
        imageData: Data? = nil,
        note: String? = nil,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) async throws -> ___VARIABLE_modelName___ {
        try await storage.save(name: name, color: color, date: date, imageData: imageData, note: note, ___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id)
    }

    public func save(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async throws -> [___VARIABLE_modelName___] {
        try await storage.save(___VARIABLE_modelPluralVariableName___)
    }

    public func duplicate(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async throws -> ___VARIABLE_modelName___ {
        try await storage.duplicate(___VARIABLE_modelVariableName___)
    }

    public func fetch(
        filterType: ___VARIABLE_modelName___FilterType? = nil,
        sortType: ___VARIABLE_modelName___SortType = .date,
        sortOrder: ___VARIABLE_modelName___SortOrder = .descending,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) async throws -> [___VARIABLE_modelName___] {
        try await storage.fetch(filterType: filterType, sortType: sortType, sortOrder: sortOrder, ___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id)
    }

    public func fetch(by id: UUID) async throws -> ___VARIABLE_modelName___ {
        try await storage.fetch(by: id)
    }

    public func search(
        query: String,
        filterType: ___VARIABLE_modelName___FilterType? = nil,
        sortType: ___VARIABLE_modelName___SortType = .date,
        sortOrder: ___VARIABLE_modelName___SortOrder = .descending
    ) async throws -> [___VARIABLE_modelName___] {
        try await storage.search(query: query, filterType: filterType, sortType: sortType, sortOrder: sortOrder)
    }

    public func update(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data?? = nil,
        note noteText: String?? = nil,
        isFavorite: Bool? = nil,
        categoryId: UUID?? = nil
    ) async throws -> ___VARIABLE_modelName___ {
        try await storage.update(___VARIABLE_modelVariableName___, name: name, color: color, date: date, image: image, note: noteText, isFavorite: isFavorite, categoryId: categoryId)
    }

    public func update___VARIABLE_categoryName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, categoryId: UUID?) async throws -> ___VARIABLE_modelName___ {
        try await storage.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: categoryId)
    }

    public func toggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async throws -> ___VARIABLE_modelName___ {
        try await storage.toggleFavorite(___VARIABLE_modelVariableName___)
    }

    public func delete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async throws {
        try await storage.delete(___VARIABLE_modelVariableName___)
    }

    public func delete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async throws {
        try await storage.delete(___VARIABLE_modelPluralVariableName___)
    }
}
