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
        emoji: String? = nil,
        color: Color,
        date: Date = Date(),
        imageData: Data? = nil,
        note: String? = nil,
        isArchive: Bool = false,
        index: Int = 0
    ) -> Result<___VARIABLE_categoryName___, Error> {
        logData("Attempting to save new ___VARIABLE_categoryName___: '\(name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___ = .init(
            imageData: imageData,
            name: name,
            emoji: emoji,
            color: color,
            date: date,
            note: note,
            isArchive: isArchive,
            index: index
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
        logData("Attempting to save \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___(s)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_categoryVariableName___ in ___VARIABLE_categoryPluralVariableName___ {
                context.insert(___VARIABLE_categoryVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved \(___VARIABLE_categoryPluralVariableName___.count) ___VARIABLE_categoryName___(s) in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Save ___VARIABLE_categoryName___(s):", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    // MARK: - Fetch Operations

    public func fetch(
        sortOrder: SortOrder = .forward,
        predicate: Predicate<___VARIABLE_categoryName___>? = nil
    ) -> Result<[___VARIABLE_categoryName___], Error> {
        logData("Fetching ___VARIABLE_categoryName___(s) with sort order: \(sortOrder)")
        let startTime = CFAbsoluteTimeGetCurrent()

        var descriptor = FetchDescriptor<___VARIABLE_categoryName___>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.index, order: sortOrder)]
        )

        do {
            let results = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched \(results.count) ___VARIABLE_categoryName___(s) in \(String(format: "%.3f", duration))s")
            return .success(results)
        } catch {
            logError("Fetch ___VARIABLE_categoryName___(s):", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchById(_ id: UUID) -> Result<___VARIABLE_categoryName___?, Error> {
        logData("Fetching ___VARIABLE_categoryName___ with ID: \(id)")
        let startTime = CFAbsoluteTimeGetCurrent()

        let predicate = #Predicate<___VARIABLE_categoryName___> { $0.id == id }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1

        do {
            let results = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched ___VARIABLE_categoryName___ by ID in \(String(format: "%.3f", duration))s")
            return .success(results.first)
        } catch {
            logError("Fetch ___VARIABLE_categoryName___ by ID:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Update Operations

    public func update(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> Result<___VARIABLE_categoryName___, Error> {
        logData("Attempting to update ___VARIABLE_categoryName___: '\(___VARIABLE_categoryVariableName___.name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully updated ___VARIABLE_categoryName___: '\(___VARIABLE_categoryVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_categoryVariableName___)
        } catch {
            logError("Update ___VARIABLE_categoryName___:", error: error)
            return .failure(SwiftDataError.updateFailed)
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
            logSuccess("Successfully deleted ___VARIABLE_categoryName___: '\(___VARIABLE_categoryVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete ___VARIABLE_categoryName___:", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }

    public func deleteAll() -> Result<Void, Error> {
        logData("Attempting to delete all ___VARIABLE_categoryName___(s)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            try context.delete(model: ___VARIABLE_categoryName___.self)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully deleted all ___VARIABLE_categoryName___(s) in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete all ___VARIABLE_categoryName___(s):", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }
}