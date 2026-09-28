// ___FILEHEADER___

@testable import ___VARIABLE_modelPackage___
import Foundation
import Models
import OversizeCore
import SwiftData
import SwiftUI
import Testing

struct ___VARIABLE_modelName___StorageServiceTests {
    private let container = ModelContainer.make(inMemory: true)

    private var storage: ___VARIABLE_modelName___StorageService {
        ___VARIABLE_modelName___StorageService(modelContainer: container)
    }

    private var categoryStorage: ___VARIABLE_categoryName___StorageService {
        ___VARIABLE_categoryName___StorageService(modelContainer: container)
    }

    @Test func `save trims name and fetches by id`() async throws {
        let storage = storage
        let saved = try await storage.save(name: "  Music  ", color: .pink, note: "Family plan")

        let fetched = try await storage.fetch(by: saved.id)

        #expect(fetched.name == "Music")
        #expect(fetched.note == "Family plan")
        #expect(try await storage.fetch().count == 1)
    }

    @Test func `save rejects blank name`() async {
        let storage = storage
        let error = await #expect(throws: PersistenceError.self) {
            _ = try await storage.save(name: "   ", color: .pink)
        }
        guard case .validationFailed = error else {
            Issue.record("Expected PersistenceError.validationFailed, got \(String(describing: error))")
            return
        }
    }

    @Test func `update clears category note and image`() async throws {
        let storage = storage
        let category = try await categoryStorage.save(name: "Video", color: .red)
        let saved = try await storage.save(
            name: "Netflix",
            color: .red,
            imageData: Data([0x01]),
            note: "Family plan",
            ___VARIABLE_categoryVariableName___Id: category.id
        )

        let updated = try await storage.update(saved, image: .some(nil), note: .some(nil), categoryId: .some(nil))

        #expect(updated.___VARIABLE_categoryVariableName___Id == nil)
        #expect(updated.note == nil)
        #expect(updated.imageData == nil)
    }

    @Test func `update keeps fields that are not passed`() async throws {
        let storage = storage
        let category = try await categoryStorage.save(name: "Video", color: .red)
        let saved = try await storage.save(name: "Netflix", color: .red, note: "Family plan", ___VARIABLE_categoryVariableName___Id: category.id)

        let updated = try await storage.update(saved, name: "Netflix HD")

        #expect(updated.name == "Netflix HD")
        #expect(updated.note == "Family plan")
        #expect(updated.___VARIABLE_categoryVariableName___Id == category.id)
    }

    @Test func `remove category through update ___VARIABLE_modelVariableName___ category`() async throws {
        let storage = storage
        let category = try await categoryStorage.save(name: "Video", color: .red)
        let saved = try await storage.save(name: "Netflix", color: .red, ___VARIABLE_categoryVariableName___Id: category.id)

        let updated = try await storage.update___VARIABLE_categoryName___(saved, categoryId: nil)

        #expect(updated.___VARIABLE_categoryVariableName___Id == nil)
    }

    @Test func `fetch by category respects favorites filter`() async throws {
        let storage = storage
        let category = try await categoryStorage.save(name: "Video", color: .red)
        let netflix = try await storage.save(name: "Netflix", color: .red, ___VARIABLE_categoryVariableName___Id: category.id)
        _ = try await storage.save(name: "Disney", color: .blue, ___VARIABLE_categoryVariableName___Id: category.id)
        _ = try await storage.save(name: "Spotify", color: .green)
        _ = try await storage.toggleFavorite(netflix)

        let inCategory = try await storage.fetch(___VARIABLE_categoryVariableName___Id: category.id)
        let favoritesInCategory = try await storage.fetch(filterType: .favorites, ___VARIABLE_categoryVariableName___Id: category.id)
        let favorites = try await storage.fetch(filterType: .favorites)

        #expect(Set(inCategory.map(\.name)) == ["Netflix", "Disney"])
        #expect(favoritesInCategory.map(\.name) == ["Netflix"])
        #expect(favorites.map(\.name) == ["Netflix"])
    }

    @Test func `batch save keeps favorite flag`() async throws {
        let storage = storage
        let favorite = ___VARIABLE_modelName___(name: "Netflix", color: .red, date: .now, isFavorite: true)

        let saved = try await storage.save([favorite])

        #expect(saved.first?.isFavorite == true)
        #expect(try await storage.fetch(by: favorite.id).isFavorite)
    }

    @Test func `toggle favorite uses persisted value`() async throws {
        let storage = storage
        let saved = try await storage.save(name: "Netflix", color: .red)
        _ = try await storage.toggleFavorite(saved)

        let toggledAgain = try await storage.toggleFavorite(saved)

        #expect(toggledAgain.isFavorite == false)
    }

    @Test func `missing ___VARIABLE_modelVariableName___ throws item not found`() async {
        let storage = storage
        let missing = ___VARIABLE_modelName___(name: "Missing", color: .gray, date: .now)

        await expectItemNotFound { _ = try await storage.fetch(by: missing.id) }
        await expectItemNotFound { _ = try await storage.update(missing, name: "Other") }
        await expectItemNotFound { try await storage.delete(missing) }
    }
}

// MARK: - Helpers

private extension ___VARIABLE_modelName___StorageServiceTests {
    func expectItemNotFound(_ operation: () async throws -> Void) async {
        let error = await #expect(throws: PersistenceError.self) {
            try await operation()
        }
        guard case .itemNotFound = error else {
            Issue.record("Expected PersistenceError.itemNotFound, got \(String(describing: error))")
            return
        }
    }
}
