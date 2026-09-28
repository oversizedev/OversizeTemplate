// ___FILEHEADER___

@testable import ___VARIABLE_modelPackage___
import Foundation
import Models
import OversizeCore
import SwiftData
import SwiftUI
import Testing

struct ___VARIABLE_categoryName___StorageServiceTests {
    private let container = ModelContainer.make(inMemory: true)

    private var storage: ___VARIABLE_categoryName___StorageService {
        ___VARIABLE_categoryName___StorageService(modelContainer: container)
    }

    @Test func `save rejects duplicate name ignoring case`() async throws {
        let storage = storage
        _ = try await storage.save(name: "Video", color: .red)

        await expectDuplicateItem { _ = try await storage.save(name: " video ", color: .blue) }
        #expect(try await storage.fetch().count == 1)
    }

    @Test func `update rejects name taken by another category`() async throws {
        let storage = storage
        _ = try await storage.save(name: "Video", color: .red)
        let music = try await storage.save(name: "Music", color: .blue)

        await expectDuplicateItem { _ = try await storage.update(music, name: "VIDEO") }
    }

    @Test func `update allows keeping own name`() async throws {
        let storage = storage
        let video = try await storage.save(name: "Video", color: .red)

        let updated = try await storage.update(video, name: "Video", note: .some("Streaming"))

        #expect(updated.name == "Video")
        #expect(updated.note == "Streaming")
        #expect(try await storage.isNameTaken("video", excludingId: video.id) == false)
    }

    @Test func `duplicate picks free copy name`() async throws {
        let storage = storage
        let video = try await storage.save(name: "Video", color: .red)

        let firstCopy = try await storage.duplicate(video)
        let secondCopy = try await storage.duplicate(video)

        #expect(firstCopy.name == "Video (Copy)")
        #expect(secondCopy.name == "Video (Copy) 2")
    }

    @Test func `remove ___VARIABLE_modelPluralVariableName___ ignores other categories`() async throws {
        let storage = storage
        let ___VARIABLE_modelVariableName___Storage = ___VARIABLE_modelName___StorageService(modelContainer: container)
        let video = try await storage.save(name: "Video", color: .red)
        let music = try await storage.save(name: "Music", color: .blue)
        let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___Storage.save(name: "Spotify", color: .green, ___VARIABLE_categoryVariableName___Id: music.id)

        _ = try await storage.remove___VARIABLE_modelName___s([___VARIABLE_modelVariableName___], from: video)

        #expect(try await ___VARIABLE_modelVariableName___Storage.fetch(by: ___VARIABLE_modelVariableName___.id).___VARIABLE_categoryVariableName___Id == music.id)
    }

    @Test func `delete keeps ___VARIABLE_modelPluralVariableName___ without category`() async throws {
        let storage = storage
        let ___VARIABLE_modelVariableName___Storage = ___VARIABLE_modelName___StorageService(modelContainer: container)
        let video = try await storage.save(name: "Video", color: .red)
        let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___Storage.save(name: "Netflix", color: .red, ___VARIABLE_categoryVariableName___Id: video.id)

        try await storage.delete(video)

        let fetched = try await ___VARIABLE_modelVariableName___Storage.fetch(by: ___VARIABLE_modelVariableName___.id)
        #expect(fetched.___VARIABLE_categoryVariableName___Id == nil)
    }
}

// MARK: - Helpers

private extension ___VARIABLE_categoryName___StorageServiceTests {
    func expectDuplicateItem(_ operation: () async throws -> Void) async {
        let error = await #expect(throws: PersistenceError.self) {
            try await operation()
        }
        guard case .duplicateItem = error else {
            Issue.record("Expected PersistenceError.duplicateItem, got \(String(describing: error))")
            return
        }
    }
}
