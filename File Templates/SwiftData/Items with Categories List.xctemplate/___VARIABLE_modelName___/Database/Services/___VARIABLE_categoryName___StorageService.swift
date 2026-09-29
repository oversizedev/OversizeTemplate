// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@ModelActor
public actor ___VARIABLE_categoryName___StorageService {
    // MARK: - Validation

    public func isNameTaken(_ name: String, excludingId: UUID? = nil) throws -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        do {
            let entities = try modelContext.fetch(FetchDescriptor<___VARIABLE_categoryName___Entity>())
            return entities.contains { entity in
                entity.id != excludingId && entity.name.caseInsensitiveCompare(trimmedName) == .orderedSame
            }
        } catch {
            Log.error("Check ___VARIABLE_categoryName___ name uniqueness failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Save Operations

    public func save(
        name: String,
        emoji: String? = nil,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil,
        index: Int = 0
    ) throws -> ___VARIABLE_categoryName___ {
        let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
            imageData: image,
            name: name,
            emoji: emoji,
            color: color,
            date: date,
            note: note,
            index: index
        )

        let results = try save([___VARIABLE_categoryVariableName___])
        guard let result = results.first else {
            throw PersistenceError.saveFailed
        }
        return result
    }

    public func save(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) throws -> [___VARIABLE_categoryName___] {
        let count = ___VARIABLE_categoryPluralVariableName___.count
        Log.debug("Saving \(count) ___VARIABLE_categoryName___(s)")

        do {
            var saved___VARIABLE_modelName___Categories: [___VARIABLE_categoryName___Entity] = []
            var reservedNames: [String] = []

            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                let name = try validatedName(___VARIABLE_categoryVariableName___.name)
                let isReserved = reservedNames.contains { $0.caseInsensitiveCompare(name) == .orderedSame }
                let isTaken = try isNameTaken(name)
                if isReserved || isTaken {
                    throw PersistenceError.duplicateItem
                }
                reservedNames.append(name)

                let entity = ___VARIABLE_categoryName___Entity(from: ___VARIABLE_categoryVariableName___)
                entity.name = name
                modelContext.insert(entity)
                saved___VARIABLE_modelName___Categories.append(entity)
            }

            try modelContext.save()
            return saved___VARIABLE_modelName___Categories.map { ___VARIABLE_categoryName___(from: $0) }
        } catch let error as PersistenceError {
            modelContext.rollback()
            throw error
        } catch {
            modelContext.rollback()
            Log.error("Save failed:", error: error)
            throw count == 1 ? PersistenceError.saveFailed : PersistenceError.batchOperationFailed
        }
    }

    public func duplicate(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) throws -> ___VARIABLE_categoryName___ {
        let duplicated___VARIABLE_categoryName___ = try ___VARIABLE_categoryName___(
            imageData: ___VARIABLE_categoryVariableName___.imageData,
            name: availableCopyName(for: ___VARIABLE_categoryVariableName___.name),
            emoji: ___VARIABLE_categoryVariableName___.emoji,
            color: ___VARIABLE_categoryVariableName___.color,
            date: Date(),
            note: ___VARIABLE_categoryVariableName___.note,
            index: 0
        )

        let results = try save([duplicated___VARIABLE_categoryName___])
        guard let result = results.first else {
            throw PersistenceError.saveFailed
        }
        return result
    }

    // MARK: - Fetch Operations

    public func fetch(
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) throws -> [___VARIABLE_categoryName___] {
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
            Log.error("Fetch failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    public func fetch(by id: UUID) throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___ = try fetch___VARIABLE_categoryName___(by: id)
            return ___VARIABLE_categoryName___(from: ___VARIABLE_categoryVariableName___)
        } catch let error as PersistenceError {
            throw error
        } catch {
            Log.error("Fetch by id failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Search

    public func search(
        query: String,
        filterType: ___VARIABLE_categoryName___FilterType? = nil,
        sortType: ___VARIABLE_categoryName___SortType = .date,
        sortOrder: ___VARIABLE_categoryName___SortOrder = .descending
    ) throws -> [___VARIABLE_categoryName___] {
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
            Log.error("Search failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Update Operations

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
    ) throws -> ___VARIABLE_categoryName___ {
        do {
            let entity = try fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

            if let name {
                let trimmedName = try validatedName(name)
                if try isNameTaken(trimmedName, excludingId: entity.id) {
                    throw PersistenceError.duplicateItem
                }
                entity.name = trimmedName
            }
            if let emoji {
                entity.emoji = emoji
            }
            if let color {
                entity.colorData = .init(color: color)
            }
            if let date {
                entity.date = date
            }
            if let image {
                entity.imageData = image
            }
            if let noteText {
                entity.note = noteText
            }
            if let isFavorite {
                entity.isFavorite = isFavorite
            }
            if let index {
                entity.index = index
            }

            try modelContext.save()
            return ___VARIABLE_categoryName___(from: entity)
        } catch let error as PersistenceError {
            modelContext.rollback()
            throw error
        } catch {
            modelContext.rollback()
            Log.error("Update failed:", error: error)
            throw PersistenceError.updateFailed
        }
    }

    public func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) throws -> ___VARIABLE_categoryName___ {
        let entity = try fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)
        return try update(___VARIABLE_categoryVariableName___, isFavorite: !entity.isFavorite)
    }

    // MARK: - Delete Operations

    public func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) throws {
        try delete([___VARIABLE_categoryVariableName___])
    }

    public func delete(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) throws {
        do {
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                let entity = try fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)
                for ___VARIABLE_modelVariableName___ in entity.___VARIABLE_modelPluralVariableName___ {
                    ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___ = nil
                }
                modelContext.delete(entity)
            }
            try modelContext.save()
        } catch let error as PersistenceError {
            modelContext.rollback()
            throw error
        } catch {
            modelContext.rollback()
            Log.error("Delete failed:", error: error)
            throw PersistenceError.deleteFailed
        }
    }

    // MARK: - Relationship Management

    public func add___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], to ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___Entity = try fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

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
        } catch let error as PersistenceError {
            modelContext.rollback()
            throw error
        } catch {
            modelContext.rollback()
            Log.error("Add ___VARIABLE_modelPluralVariableName___ to ___VARIABLE_categoryVariableName___ failed:", error: error)
            throw PersistenceError.saveFailed
        }
    }

    public func remove___VARIABLE_modelName___s(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___], from ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) throws -> ___VARIABLE_categoryName___ {
        do {
            let ___VARIABLE_categoryVariableName___Entity = try fetch___VARIABLE_categoryName___(by: ___VARIABLE_categoryVariableName___.id)

            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                let ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
                let ___VARIABLE_modelVariableName___Descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
                    predicate: #Predicate { $0.id == ___VARIABLE_modelVariableName___Id }
                )
                if let ___VARIABLE_modelVariableName___Entity = try modelContext.fetch(___VARIABLE_modelVariableName___Descriptor).first,
                   ___VARIABLE_modelVariableName___Entity.___VARIABLE_categoryVariableName___?.id == ___VARIABLE_categoryVariableName___Entity.id
                {
                    ___VARIABLE_modelVariableName___Entity.___VARIABLE_categoryVariableName___ = nil
                }
            }

            try modelContext.save()
            return ___VARIABLE_categoryName___(from: ___VARIABLE_categoryVariableName___Entity)
        } catch let error as PersistenceError {
            modelContext.rollback()
            throw error
        } catch {
            modelContext.rollback()
            Log.error("Remove ___VARIABLE_modelPluralVariableName___ from ___VARIABLE_categoryVariableName___ failed:", error: error)
            throw PersistenceError.saveFailed
        }
    }

    // MARK: - Count Operations

    public func count() throws -> Int {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>()
            return try modelContext.fetchCount(descriptor)
        } catch {
            Log.error("Count failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Lazy Loading

    public func fetch___VARIABLE_modelName___s(for ___VARIABLE_categoryVariableName___Id: UUID) throws -> [___VARIABLE_modelName___] {
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
            Log.error("Lazy load ___VARIABLE_modelPluralVariableName___ failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Private Helper Methods

    private func fetch___VARIABLE_categoryName___(by id: UUID) throws -> ___VARIABLE_categoryName___Entity {
        let descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let ___VARIABLE_categoryVariableName___ = try modelContext.fetch(descriptor).first else {
            throw PersistenceError.itemNotFound
        }
        return ___VARIABLE_categoryVariableName___
    }

    private func validatedName(_ name: String) throws -> String {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            throw PersistenceError.validationFailed(reason: "Category name cannot be empty")
        }
        return trimmedName
    }

    private func availableCopyName(for name: String) throws -> String {
        let baseName = "\(name) (Copy)"
        var candidate = baseName
        var copyNumber = 2
        while try isNameTaken(candidate) {
            candidate = "\(baseName) \(copyNumber)"
            copyNumber += 1
        }
        return candidate
    }
}
