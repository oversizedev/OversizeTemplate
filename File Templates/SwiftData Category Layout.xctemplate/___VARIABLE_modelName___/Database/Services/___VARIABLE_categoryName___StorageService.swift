// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

public actor ___VARIABLE_categoryName___StorageService: ModelActor {
    public let modelContainer: ModelContainer
    public let modelExecutor: any ModelExecutor
    let context: ModelContext

    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    // MARK: - Save Operations

    public func save(
        name: String,
        color: Color,
        image: Data? = nil,
        note: String? = nil,
        sortOrder: Int = 0
    ) -> Result<___VARIABLE_categoryName___, Error> {
        logData("Attempting to save new ___VARIABLE_categoryName___: '\(name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___ = .init(
            name: name,
            color: color,
            image: image,
            note: note,
            sortOrder: sortOrder
        )

        do {
            context.insert(___VARIABLE_categoryVariableName___)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved ___VARIABLE_categoryName___: '\(name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_categoryVariableName___)
        } catch {
            logError("Save ___VARIABLE_categoryName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    public func save(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> Result<Void, Error> {
        logData("Attempting to save \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                context.insert(___VARIABLE_categoryVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Save multiple ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    // MARK: - Fetch Operations

    public func fetchAll() -> Result<[___VARIABLE_categoryName___], Error> {
        logData("Fetching all ___VARIABLE_categoryName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
                sortBy: [
                    SortDescriptor(\___VARIABLE_categoryName___.sortOrder, order: .forward),
                    SortDescriptor(\___VARIABLE_categoryName___.name, order: .forward)
                ]
            )
            let ___VARIABLE_categoryPluralVariableName___ = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_categoryPluralVariableName___)
        } catch {
            logError("Fetch all ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchAllSorted(
        sortType: ___VARIABLE_categoryName___SortType,
        sortOrder: ___VARIABLE_categoryName___SortOrder
    ) -> Result<[___VARIABLE_categoryName___], Error> {
        logData("Fetching sorted ___VARIABLE_categoryName___s (sort: \(sortType)/\(sortOrder))")

        do {
            let sortDescriptor = sortType.sortDescriptor(order: sortOrder)
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
                sortBy: [sortDescriptor]
            )

            let ___VARIABLE_categoryPluralVariableName___ = try context.fetch(descriptor)
            logSuccess("Successfully fetched \(___VARIABLE_categoryPluralVariableName___.count) sorted ___VARIABLE_categoryName___s")
            return .success(___VARIABLE_categoryPluralVariableName___)
        } catch {
            logError("Fetch sorted ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetch(by id: UUID) -> Result<___VARIABLE_categoryName___, Error> {
        logData("Fetching ___VARIABLE_categoryName___ by ID: \(id)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
                predicate: #Predicate { $0.id == id }
            )
            guard let ___VARIABLE_categoryVariableName___ = try context.fetch(descriptor).first else {
                logError("___VARIABLE_categoryName___ not found with id: \(id)")
                return .failure(SwiftDataError.itemNotFound)
            }
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched ___VARIABLE_categoryName___ '\(___VARIABLE_categoryVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_categoryVariableName___)
        } catch {
            logError("Fetch ___VARIABLE_categoryName___ by id:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Search

    public func search(query: String) -> Result<[___VARIABLE_categoryName___], Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
                predicate: #Predicate { ___VARIABLE_categoryVariableName___ in
                    ___VARIABLE_categoryVariableName___.name.localizedStandardContains(query) ||
                        (___VARIABLE_categoryVariableName___.note?.localizedStandardContains(query) == true)
                },
                sortBy: [
                    SortDescriptor(\___VARIABLE_categoryName___.sortOrder, order: .forward),
                    SortDescriptor(\___VARIABLE_categoryName___.name, order: .forward)
                ]
            )

            let ___VARIABLE_categoryPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_categoryPluralVariableName___)
        } catch {
            logError("Search ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Count Operations

    public func count() -> Result<Int, Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>()
            let count = try context.fetchCount(descriptor)
            return .success(count)
        } catch {
            logError("Count ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Update Operations

    public func update(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        name: String? = nil,
        color: Color? = nil,
        image: Data? = nil,
        note: String? = nil,
        sortOrder: Int? = nil
    ) {
        logData("Updating ___VARIABLE_categoryName___: '\(___VARIABLE_categoryVariableName___.name)'")

        if let name {
            ___VARIABLE_categoryVariableName___.name = name
        }
        if let color {
            ___VARIABLE_categoryVariableName___.colorData = .init(color: color)
        }
        if let image {
            ___VARIABLE_categoryVariableName___.imageData = image
        }
        if let note {
            ___VARIABLE_categoryVariableName___.note = note
        }
        if let sortOrder {
            ___VARIABLE_categoryVariableName___.sortOrder = sortOrder
        }
    }

    // MARK: - Delete Operations

    public func delete(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> Result<Void, Error> {
        logData("Attempting to delete ___VARIABLE_categoryName___: '\(___VARIABLE_categoryVariableName___.name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            context.delete(___VARIABLE_categoryVariableName___)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDeleted("___VARIABLE_categoryName___ '\(___VARIABLE_categoryVariableName___.name)' deleted successfully")
            logDebug("Deletion of ___VARIABLE_categoryName___ '\(___VARIABLE_categoryVariableName___.name)' took \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete ___VARIABLE_categoryName___:", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }

    public func delete(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> Result<Void, Error> {
        logData("Attempting to delete \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                context.delete(___VARIABLE_categoryVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDeleted("\(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s deleted successfully in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete multiple ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    public func deleteAll() -> Result<Void, Error> {
        logData("Attempting to delete all ___VARIABLE_categoryName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>()
            let ___VARIABLE_categoryPluralVariableName___ = try context.fetch(descriptor)
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                context.delete(___VARIABLE_categoryVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDeleted("All \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___s deleted successfully in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete all ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    // MARK: - Validation

    public func exists(with id: UUID) -> Bool {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
                predicate: #Predicate { $0.id == id }
            )
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            logError("Check if ___VARIABLE_categoryName___ exists:", error: error)
            return false
        }
    }

    public func validate(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> Result<Void, Error> {
        guard !___VARIABLE_categoryVariableName___.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .failure(SwiftDataError.validationFailed(reason: "Name cannot be empty"))
        }
        return .success(())
    }

    // MARK: - Sort Order Operations

    public func updateSortOrder(_ ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> Result<Void, Error> {
        do {
            for (index, ___VARIABLE_categoryVariableName___) in ___VARIABLE_categoryPluralVariableName___.enumerated() {
                ___VARIABLE_categoryVariableName___.sortOrder = index
            }
            try context.save()
            return .success(())
        } catch {
            logError("Update sort order for ___VARIABLE_categoryName___s:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }
}