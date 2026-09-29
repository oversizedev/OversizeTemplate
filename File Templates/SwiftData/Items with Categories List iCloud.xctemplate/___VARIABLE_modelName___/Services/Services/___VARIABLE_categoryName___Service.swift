// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Foundation
import Models
import SwiftUI

public actor ___VARIABLE_categoryName___Service {
    @LazyInjected(\.___VARIABLE_categoryVariableName___StorageService) private var storage: ___VARIABLE_categoryName___StorageService

    public init() {}

    public func isNameTaken(_ name: String, excludingId: UUID? = nil) async throws -> Bool {
        try await storage.isNameTaken(name, excludingId: excludingId)
    }

    public func save(
        name: String,
        emoji: String? = nil,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil,
        index: Int = 0
    ) async throws -> ___VARIABLE_categoryName___ {
        try await storage.save(name: name, emoji: emoji, color: color, date: date, image: image, note: note, index: index)
    }

    public func save(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) async throws -> [___VARIABLE_categoryName___] {
        try await storage.save(___VARIABLE_categoryPluralVariableName___)
    }

    public func duplicate(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        try await storage.duplicate(___VARIABLE_categoryVariableName___)
    }

    public func fetch(
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) async throws -> [___VARIABLE_categoryName___] {
        try await storage.fetch(filterType: filterType, sortType: sortType, sortOrder: sortOrder)
    }

    public func fetch(by id: UUID) async throws -> ___VARIABLE_categoryName___ {
        try await storage.fetch(by: id)
    }

    public func search(
        query: String,
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) async throws -> [___VARIABLE_categoryName___] {
        try await storage.search(query: query, filterType: filterType, sortType: sortType, sortOrder: sortOrder)
    }

    public func update(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        name: String? = nil,
        emoji: String?? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data?? = nil,
        note noteText: String?? = nil,
        isFavorite: Bool? = nil,
        index: Int? = nil
    ) async throws -> ___VARIABLE_categoryName___ {
        try await storage.update(___VARIABLE_categoryVariableName___, name: name, emoji: emoji, color: color, date: date, image: image, note: noteText, isFavorite: isFavorite, index: index)
    }

    public func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        try await storage.toggleFavorite(___VARIABLE_categoryVariableName___)
    }

    public func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws {
        try await storage.delete(___VARIABLE_categoryVariableName___)
    }

    public func delete(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) async throws {
        try await storage.delete(___VARIABLE_categoryPluralVariableName___)
    }

    public func add___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], to ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        try await storage.add___VARIABLE_modelName___s(___VARIABLE_modelPluralVariableName___, to: ___VARIABLE_categoryVariableName___)
    }

    public func remove___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], from ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        try await storage.remove___VARIABLE_modelName___s(___VARIABLE_modelPluralVariableName___, from: ___VARIABLE_categoryVariableName___)
    }

    public func count() async throws -> Int {
        try await storage.count()
    }

    public func fetch___VARIABLE_modelName___s(for ___VARIABLE_categoryVariableName___Id: UUID) async throws -> [___VARIABLE_modelName___] {
        try await storage.fetch___VARIABLE_modelName___s(for: ___VARIABLE_categoryVariableName___Id)
    }
}
