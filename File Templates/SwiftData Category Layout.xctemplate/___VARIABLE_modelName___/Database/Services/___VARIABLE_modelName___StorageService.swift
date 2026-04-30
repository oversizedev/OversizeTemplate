// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@ModelActor
public actor ___VARIABLE_modelName___StorageService {
    // MARK: - Save Operations

    public func save(
        name: String,
        color: Color,
        date: Date = Date(),
        imageData: Data? = nil,
        note: String? = nil,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) throws -> ___VARIABLE_modelName___ {
        let ___VARIABLE_modelVariableName___ = ___VARIABLE_modelName___(
            imageData: imageData,
            name: name,
            color: color,
            date: date,
            note: note,
            ___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id
        )

        let results = try save([___VARIABLE_modelVariableName___])
        guard let result = results.first else {
            throw PersistenceError.saveFailed
        }
        return result
    }

    public func save(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) throws -> [___VARIABLE_modelName___] {
        let count = ___VARIABLE_modelPluralVariableName___.count
        logData("Saving \(count) ___VARIABLE_modelName___(s)")

        do {
            var saved___VARIABLE_modelName___s: [___VARIABLE_modelName___Entity] = []

            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                var ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity? = nil

                if let ___VARIABLE_categoryVariableName___Id = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id {
                    let ___VARIABLE_categoryVariableName___Descriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>(
                        predicate: #Predicate { $0.id == ___VARIABLE_categoryVariableName___Id }
                    )
                    ___VARIABLE_categoryVariableName___ = try modelContext.fetch(___VARIABLE_categoryVariableName___Descriptor).first
                }

                let entity = ___VARIABLE_modelName___Entity(
                    id: ___VARIABLE_modelVariableName___.id,
                    name: ___VARIABLE_modelVariableName___.name,
                    color: ___VARIABLE_modelVariableName___.color,
                    date: ___VARIABLE_modelVariableName___.date,
                    image: ___VARIABLE_modelVariableName___.imageData,
                    note: ___VARIABLE_modelVariableName___.note,
                    ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___
                )

                modelContext.insert(entity)
                saved___VARIABLE_modelName___s.append(entity)
            }

            try modelContext.save()
            return saved___VARIABLE_modelName___s.map { ___VARIABLE_modelName___(from: $0) }
        } catch {
            logError("Save failed:", error: error)
            throw count == 1 ? PersistenceError.saveFailed : PersistenceError.batchOperationFailed
        }
    }

    public func duplicate(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) throws -> ___VARIABLE_modelName___ {
        let duplicated___VARIABLE_modelName___ = ___VARIABLE_modelName___(
            imageData: ___VARIABLE_modelVariableName___.imageData,
            name: "\(___VARIABLE_modelVariableName___.name) (Copy)",
            color: ___VARIABLE_modelVariableName___.color,
            date: Date(),
            note: ___VARIABLE_modelVariableName___.note,
            ___VARIABLE_categoryVariableName___Id: ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id
        )

        let results = try save([duplicated___VARIABLE_modelName___])
        guard let result = results.first else {
            throw PersistenceError.saveFailed
        }

        return result
    }

    // MARK: - Fetch Operations

    public func fetch(
        filterType: ___VARIABLE_modelName___FilterType? = nil,
        sortType: ___VARIABLE_modelName___SortType = .date,
        sortOrder: ___VARIABLE_modelName___SortOrder = .descending,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) throws -> [___VARIABLE_modelName___] {
        do {
            var predicate: Predicate<___VARIABLE_modelName___Entity>?

            if let ___VARIABLE_categoryVariableName___Id {
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___?.id == ___VARIABLE_categoryVariableName___Id
                }
            } else if let filterPredicate = filterType?.filterPredicate {
                predicate = filterPredicate
            }

            let sortDescriptor = sortType.sortDescriptor(order: sortOrder)
            let descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
                predicate: predicate,
                sortBy: [sortDescriptor]
            )

            let ___VARIABLE_modelPluralVariableName___ = try modelContext.fetch(descriptor)
            return ___VARIABLE_modelPluralVariableName___.map { ___VARIABLE_modelName___(from: $0) }
        } catch {
            logError("Fetch failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    public func fetch(by id: UUID) throws -> ___VARIABLE_modelName___ {
        do {
            let ___VARIABLE_modelVariableName___ = try fetch___VARIABLE_modelName___(by: id)
            return ___VARIABLE_modelName___(from: ___VARIABLE_modelVariableName___)
        } catch {
            logError("Fetch by id failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Search

    public func search(
        query: String,
        filterType: ___VARIABLE_modelName___FilterType? = nil,
        sortType: ___VARIABLE_modelName___SortType = .date,
        sortOrder: ___VARIABLE_modelName___SortOrder = .descending
    ) throws -> [___VARIABLE_modelName___] {
        do {
            let sortDescriptor = sortType.sortDescriptor(order: sortOrder)
            let descriptor = if filterType == .favorites {
                FetchDescriptor<___VARIABLE_modelName___Entity>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.isFavorite &&
                            (___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                                (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true))
                    },
                    sortBy: [sortDescriptor]
                )
            } else {
                FetchDescriptor<___VARIABLE_modelName___Entity>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true)
                    },
                    sortBy: [sortDescriptor]
                )
            }

            let ___VARIABLE_modelPluralVariableName___ = try modelContext.fetch(descriptor)
            return ___VARIABLE_modelPluralVariableName___.map { ___VARIABLE_modelName___(from: $0) }
        } catch {
            logError("Search failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    // MARK: - Update Operations

    public func update(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        categoryId: UUID? = nil
    ) throws -> ___VARIABLE_modelName___ {
        do {
            let ___VARIABLE_modelVariableName___Entity = try fetch___VARIABLE_modelName___(by: ___VARIABLE_modelVariableName___.id)

            if let name { ___VARIABLE_modelVariableName___Entity.name = name }
            if let color { ___VARIABLE_modelVariableName___Entity.colorData = .init(color: color) }
            if let date { ___VARIABLE_modelVariableName___Entity.date = date }
            if let image { ___VARIABLE_modelVariableName___Entity.imageData = image }
            if let note { ___VARIABLE_modelVariableName___Entity.note = note }
            if let isFavorite { ___VARIABLE_modelVariableName___Entity.isFavorite = isFavorite }
            if let categoryId {
                let categoryDescriptor = FetchDescriptor<___VARIABLE_categoryName___Entity>(
                    predicate: #Predicate { $0.id == categoryId }
                )
                ___VARIABLE_modelVariableName___Entity.___VARIABLE_categoryVariableName___ = try modelContext.fetch(categoryDescriptor).first
            }
            try modelContext.save()
            return ___VARIABLE_modelName___(from: ___VARIABLE_modelVariableName___Entity)
        } catch {
            logError("Update failed:", error: error)
            throw PersistenceError.saveFailed
        }
    }

    public func updateCategory(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, categoryId: UUID?) throws -> ___VARIABLE_modelName___ {
        try update(___VARIABLE_modelVariableName___, categoryId: categoryId)
    }

    public func toggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) throws -> ___VARIABLE_modelName___ {
        try update(___VARIABLE_modelVariableName___, isFavorite: !___VARIABLE_modelVariableName___.isFavorite)
    }

    public func incrementViewCount(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) throws -> ___VARIABLE_modelName___ {
        do {
            let ___VARIABLE_modelVariableName___Entity = try fetch___VARIABLE_modelName___(by: ___VARIABLE_modelVariableName___.id)
            ___VARIABLE_modelVariableName___Entity.viewCount += 1
            try modelContext.save()
            return ___VARIABLE_modelName___(from: ___VARIABLE_modelVariableName___Entity)
        } catch {
            logError("Increment view count failed:", error: error)
            throw PersistenceError.saveFailed
        }
    }

    // MARK: - Delete Operations

    public func delete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) throws {
        try delete([___VARIABLE_modelVariableName___])
    }

    public func delete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) throws {
        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                let ___VARIABLE_modelVariableName___Entity = try fetch___VARIABLE_modelName___(by: ___VARIABLE_modelVariableName___.id)
                modelContext.delete(___VARIABLE_modelVariableName___Entity)
            }
            try modelContext.save()
        } catch {
            logError("Delete failed:", error: error)
            throw PersistenceError.deleteFailed
        }
    }

    // MARK: - Private Helper Methods

    private func fetch___VARIABLE_modelName___(by id: UUID) throws -> ___VARIABLE_modelName___Entity {
        let descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let ___VARIABLE_modelVariableName___ = try modelContext.fetch(descriptor).first else {
            throw PersistenceError.itemNotFound
        }
        return ___VARIABLE_modelVariableName___
    }
}
