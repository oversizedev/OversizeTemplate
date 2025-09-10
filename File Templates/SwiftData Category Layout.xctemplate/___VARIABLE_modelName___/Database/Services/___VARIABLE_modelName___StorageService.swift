// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

public actor ___VARIABLE_modelName___StorageService: ModelActor {
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
        date: Date = Date(),
        imageData: Data? = nil,
        note: String? = nil,
        isArchive: Bool = false,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) -> Result<___VARIABLE_modelName___, Error> {
        logData("Attempting to save new ___VARIABLE_modelName___: '\(name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___ = .init(
            imageData: imageData,
            name: name,
            color: color,
            date: date,
            note: note,
            isArchive: isArchive,
            ___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id
        )

        do {
            context.insert(___VARIABLE_modelVariableName___)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved ___VARIABLE_modelName___: '\(name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Save ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    public func save(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> Result<Void, Error> {
        logData("Attempting to save \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___(s)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                context.insert(___VARIABLE_modelVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___(s) in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Save ___VARIABLE_modelName___(s):", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    // MARK: - Fetch Operations

    public func fetch(
        sortOrder: SortOrder = .forward,
        predicate: Predicate<___VARIABLE_modelName___>? = nil
    ) -> Result<[___VARIABLE_modelName___], Error> {
        logData("Fetching ___VARIABLE_modelName___(s) with sort order: \(sortOrder)")
        let startTime = CFAbsoluteTimeGetCurrent()

        var descriptor = FetchDescriptor<___VARIABLE_modelName___>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.date, order: sortOrder)]
        )

        do {
            let results = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched \(results.count) ___VARIABLE_modelName___(s) in \(String(format: "%.3f", duration))s")
            return .success(results)
        } catch {
            logError("Fetch ___VARIABLE_modelName___(s):", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchById(_ id: UUID) -> Result<___VARIABLE_modelName___?, Error> {
        logData("Fetching ___VARIABLE_modelName___ with ID: \(id)")
        let startTime = CFAbsoluteTimeGetCurrent()

        let predicate = #Predicate<___VARIABLE_modelName___> { $0.id == id }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1

        do {
            let results = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched ___VARIABLE_modelName___ by ID in \(String(format: "%.3f", duration))s")
            return .success(results.first)
        } catch {
            logError("Fetch ___VARIABLE_modelName___ by ID:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Update Operations

    public func update(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<___VARIABLE_modelName___, Error> {
        logData("Attempting to update ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully updated ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Update ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.updateFailed)
        }
    }

    // MARK: - Delete Operations

    public func delete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, Error> {
        logData("Attempting to delete ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            context.delete(___VARIABLE_modelVariableName___)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully deleted ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }

    public func deleteAll() -> Result<Void, Error> {
        logData("Attempting to delete all ___VARIABLE_modelName___(s)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            try context.delete(model: ___VARIABLE_modelName___.self)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully deleted all ___VARIABLE_modelName___(s) in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete all ___VARIABLE_modelName___(s):", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }
}