// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@ModelActor
public actor ___VARIABLE_categoryName___StorageService {
    // MARK: - Save Operations

    public func save(
        name: String,
        emoji: String? = nil,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil,
        index: Int = 0
    ) async throws -> ___VARIABLE_categoryName___ {
        let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
            imageData: image,
            name: name,
            emoji: emoji,
            color: color,
            date: date,
            note: note,
            index: index
        )

        let results = try await save([___VARIABLE_categoryVariableName___])
        guard let result = results.first else {
            throw SwiftDataError.saveFailed
        }
        return result
    }

    public func save(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) async throws -> [___VARIABLE_categoryName___] {
        let count = ___VARIABLE_categoryPluralVariableName___.count
        logData("Saving \(count) ___VARIABLE_categoryName___(s)")

        do {
            var saved___VARIABLE_categoryName___s: [___VARIABLE_categoryName___Entity] = []

            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                let entity = ___VARIABLE_categoryName___Entity(from: ___VARIABLE_categoryVariableName___)
                modelContext.insert(entity)
                saved___VARIABLE_categoryName___s.append(entity)
            }

            try modelContext.save()
            return saved___VARIABLE_categoryName___s.map { ___VARIABLE_categoryName___(from: $0) }
        } catch {
            logError("Save failed:", error: error)
            throw count == 1 ? SwiftDataError.saveFailed : SwiftDataError.batchOperationFailed
        }
    }

    public func duplicate(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        let duplicated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
            imageData: ___VARIABLE_categoryVariableName___.imageData,
            name: "\(___VARIABLE_categoryVariableName___.name) (Copy)",
            emoji: ___VARIABLE_categoryVariableName___.emoji,
            color: ___VARIABLE_categoryVariableName___.color,
            date: Date(),
            note: ___VARIABLE_categoryVariableName___.note,
            index: 0
        )

        let results = try await save([duplicated___VARIABLE_categoryName___])
        guard let result = results.first else {
            throw SwiftDataError.saveFailed
        }
        return result
    }

    // MARK: - Fetch Operations

    public func fetch(
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) async throws -> [___VARIABLE_categoryName___] {
        do {
            var predicate: Predicate<___VARIABLE_categoryName___Entity>?

            if let filterType, filterType == .favorites {
                predicate = #Predicate { $0.isFavorite }
            }

            let sortDescriptor = sortType.sortDescriptor(order: sortOrder)
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>(
                predicate: predicate,
                sortBy: [sortDescriptor]
            )

            let ___VARIABLE_categoryPluralVariableName___ = try modelContext.fetch(descriptor)
            return ___VARIABLE_categoryPluralVariableName___.map { ___VARIABLE_categoryName___(from: $0) }
        } catch {
            logError("Fetch failed:", error: error)
            throw SwiftDataError.fetchFailed
        }
    }

    public func fetch(by id: UUID) async throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___ = try await fetch___VARIABLE_categoryName___(by: id)
            return ___VARIABLE_categoryName___(from: ___VARIABLE_categoryVariableName___)
        } catch {
            logError("Fetch by id failed:", error: error)
            throw SwiftDataError.fetchFailed
        }
    }

    // MARK: - Search

    public func search(
        query: String,
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) async throws -> [___VARIABLE_categoryName___] {
        do {
            let sortDescriptor = sortType.sortDescriptor(order: sortOrder)
            let descriptor = if filterType == .favorites {
                FetchDescriptor<___VARIABLE_categoryName___Entity>(
                    predicate: #Predicate { ___VARIABLE_categoryVariableName___ in
                        ___VARIABLE_categoryVariableName___.isFavorite &&
                            (___VARIABLE_categoryVariableName___.name.localizedStandardContains(query) ||
                                (___VARIABLE_categoryVariableName___.note?.localizedStandardContains(query) == true))
                    },
                    sortBy: [sortDescriptor]
                )
            } else {
                FetchDescriptor<___VARIABLE_categoryName___Entity>(
                    predicate: #Predicate { ___VARIABLE_categoryVariableName___ in
                        ___VARIABLE_categoryVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_categoryVariableName___.note?.localizedStandardContains(query) == true)
                    },
                    sortBy: [sortDescriptor]
                )
            }

            let ___VARIABLE_categoryPluralVariableName___ = try modelContext.fetch(descriptor)
            return ___VARIABLE_categoryPluralVariableName___.map { ___VARIABLE_categoryName___(from: $0) }
        } catch {
            logError("Search failed:", error: error)
            throw SwiftDataError.fetchFailed
        }
    }

    // MARK: - Update Operations

    public func update(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        name: String? = nil,
        emoji: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        index: Int? = nil
    ) async throws -> ___VARIABLE_categoryName___ {
        do {
            let entity = try await fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

            if let name { entity.name = name }
            if let emoji { entity.emoji = emoji }
            if let color { entity.colorData = .init(color: color) }
            if let date { entity.date = date }
            if let image { entity.imageData = image }
            if let note { entity.note = note }
            if let isFavorite { entity.isFavorite = isFavorite }
            if let index { entity.index = index }

            try modelContext.save()
            return ___VARIABLE_categoryName___(from: entity)
        } catch {
            logError("Update failed:", error: error)
            throw SwiftDataError.saveFailed
        }
    }

    public func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        try await update(___VARIABLE_categoryVariableName___, isFavorite: !___VARIABLE_categoryVariableName___.isFavorite)
    }

    public func incrementViewCount(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        do {
            let entity = try await fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)
            entity.viewCount += 1
            try modelContext.save()
            return ___VARIABLE_categoryName___(from: entity)
        } catch {
            logError("Increment view count failed:", error: error)
            throw SwiftDataError.saveFailed
        }
    }

    // MARK: - Delete Operations

    public func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws {
        try await delete([___VARIABLE_categoryVariableName___])
    }

    public func delete(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) async throws {
        do {
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                let entity = try await fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)
                for ___VARIABLE_modelVariableName___ in entity.___VARIABLE_modelPluralVariableName___ {
                    ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___ = nil
                }
                modelContext.delete(entity)
            }
            try modelContext.save()
        } catch {
            logError("Delete failed:", error: error)
            throw SwiftDataError.batchOperationFailed
        }
    }

    // MARK: - Relationship Management

    public func add___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], to ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___Entity = try await fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                let ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
                let ___VARIABLE_modelVariableName___Descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
                    predicate: #Predicate { $0.id == ___VARIABLE_modelVariableName___Id }
                )
                if let ___VARIABLE_modelVariableName___Entity = try modelContext.fetch(___VARIABLE_modelVariableName___Descriptor).first {
                    ___VARIABLE_modelVariableName___Entity.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___Entity
                }
            }

            try modelContext.save()
            return ___VARIABLE_categoryName___(from: ___VARIABLE_categoryVariableName___Entity)
        } catch {
            logError("Add ___VARIABLE_modelPluralVariableName___ to ___VARIABLE_categoryVariableName___ failed:", error: error)
            throw SwiftDataError.saveFailed
        }
    }

    public func remove___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], from ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___Entity = try await fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                let ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
                let ___VARIABLE_modelVariableName___Descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
                    predicate: #Predicate { $0.id == ___VARIABLE_modelVariableName___Id }
                )
                if let ___VARIABLE_modelVariableName___Entity = try modelContext.fetch(___VARIABLE_modelVariableName___Descriptor).first {
                    ___VARIABLE_modelVariableName___Entity.___VARIABLE_categoryVariableName___ = nil
                }
            }

            try modelContext.save()
            return ___VARIABLE_categoryName___(from: ___VARIABLE_categoryVariableName___Entity)
        } catch {
            logError("Remove ___VARIABLE_modelPluralVariableName___ from ___VARIABLE_categoryVariableName___ failed:", error: error)
            throw SwiftDataError.saveFailed
        }
    }

    // MARK: - Count Operations

    public func count() async throws -> Int {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>()
            return try modelContext.fetchCount(descriptor)
        } catch {
            logError("Count failed:", error: error)
            throw SwiftDataError.fetchFailed
        }
    }

    // MARK: - Lazy Loading

    public func fetch___VARIABLE_modelName___s(for ___VARIABLE_categoryVariableName___Id: UUID) async throws -> [___VARIABLE_modelName___] {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
                predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___?.id == ___VARIABLE_categoryVariableName___Id
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___Entity.name)]
            )

            let ___VARIABLE_modelPluralVariableName___ = try modelContext.fetch(descriptor)
            return ___VARIABLE_modelPluralVariableName___.map { ___VARIABLE_modelName___(from: $0) }
        } catch {
            logError("Lazy load ___VARIABLE_modelPluralVariableName___ failed:", error: error)
            throw SwiftDataError.fetchFailed
        }
    }

    // MARK: - Private Helper Methods

    private func fetch___VARIABLE_categoryName___(by id: UUID) async throws -> ___VARIABLE_categoryName___Entity {
        let descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let ___VARIABLE_categoryVariableName___ = try modelContext.fetch(descriptor).first else {
            throw SwiftDataError.itemNotFound
        }
        return ___VARIABLE_categoryVariableName___
    }
}
