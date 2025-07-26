//
// Copyright © 2025 Alexander Romanov
// ___VARIABLE_modelName___StorageService.swift, created on 09.07.2025
//

import OversizeCore
import SwiftData
import SwiftUI

public enum ___VARIABLE_modelName___SortType: String, CaseIterable, Sendable, Identifiable {
    case name, date, popularity

    public var id: String {
        rawValue
    }
}

public enum ___VARIABLE_modelName___SortOrder: String, CaseIterable, Sendable, Identifiable {
    case ascending, descending

    public var id: String {
        rawValue
    }
}

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
        image: Data? = nil,
        note: String? = nil,
    ) -> Result<___VARIABLE_modelName___, Error> {
        logData("Attempting to save new ___VARIABLE_modelName___: '\(name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___ = .init(
            name: name,
            color: color,
            date: date,
            image: image,
            note: note,
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
        logData("Attempting to save \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                context.insert(___VARIABLE_modelVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully saved \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Save multiple ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    // MARK: - Private Helper Methods

    private func makeSortDescriptor(
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: ___VARIABLE_modelName___SortOrder,
    ) -> SortDescriptor<___VARIABLE_modelName___> {
        let swiftDataOrder: SortOrder = sortOrder == .ascending ? .forward : .reverse
        return switch sortType {
        case .name:
            SortDescriptor(\___VARIABLE_modelName___.name, order: swiftDataOrder)
        case .date:
            SortDescriptor(\___VARIABLE_modelName___.date, order: swiftDataOrder)
        case .popularity:
            SortDescriptor(\___VARIABLE_modelName___.viewCount, order: swiftDataOrder)
        }
    }

    // MARK: - Fetch Operations

    public func fetchAll(includeArchived: Bool = false) -> Result<[___VARIABLE_modelName___], Error> {
        logData("Fetching all ___VARIABLE_modelName___s (includeArchived: \(includeArchived))")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>(
                    sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
                )
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { !$0.isArchive },
                    sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
                )
            }
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch all ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchAllSorted(
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: ___VARIABLE_modelName___SortOrder,
        includeArchived: Bool = false,
    ) -> Result<[___VARIABLE_modelName___], Error> {
        logData("Fetching sorted ___VARIABLE_modelName___s (sort: \(sortType)/\(sortOrder), includeArchived: \(includeArchived))")

        do {
            let sortDescriptor = makeSortDescriptor(sortType: sortType, sortOrder: sortOrder)

            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>(
                    sortBy: [sortDescriptor]
                )
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { !$0.isArchive },
                    sortBy: [sortDescriptor]
                )
            }

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            logSuccess("Successfully fetched \(___VARIABLE_modelPluralVariableName___.count) sorted ___VARIABLE_modelName___s")
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch sorted ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetch(by id: UUID) -> Result<___VARIABLE_modelName___, Error> {
        logData("Fetching ___VARIABLE_modelName___ by ID: \(id)")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.id == id }
            )
            guard let ___VARIABLE_modelVariableName___ = try context.fetch(descriptor).first else {
                logError("___VARIABLE_modelName___ not found with id: \(id)")
                return .failure(SwiftDataError.itemNotFound)
            }
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully fetched ___VARIABLE_modelName___ '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Fetch ___VARIABLE_modelName___ by id:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetch(from: Date, to: Date, includeArchived: Bool = false) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                    if includeArchived {
                        ___VARIABLE_modelVariableName___.date >= from && ___VARIABLE_modelVariableName___.date <= to
                    } else {
                        ___VARIABLE_modelVariableName___.date >= from && ___VARIABLE_modelVariableName___.date <= to && !___VARIABLE_modelVariableName___.isArchive
                    }
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch ___VARIABLE_modelName___s by date range:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetch(for date: Date, includeArchived: Bool = false) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
                logError("Failed to calculate endOfDay for date: \(date)")
                return .failure(SwiftDataError.invalidPredicate)
            }

            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                    if includeArchived {
                        ___VARIABLE_modelVariableName___.date >= startOfDay && ___VARIABLE_modelVariableName___.date < endOfDay
                    } else {
                        ___VARIABLE_modelVariableName___.date >= startOfDay && ___VARIABLE_modelVariableName___.date < endOfDay && !___VARIABLE_modelVariableName___.isArchive
                    }
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date)]
            )

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)

        } catch {
            logError("Fetch ___VARIABLE_modelName___s for date:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchFavorites() -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch favorite ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchArchived() -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isArchive },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch archived ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchArchivedSorted(
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: ___VARIABLE_modelName___SortOrder,
    ) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let sortDescriptor = makeSortDescriptor(sortType: sortType, sortOrder: sortOrder)
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isArchive },
                sortBy: [sortDescriptor]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch sorted archived ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func fetchFavoritesSorted(
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: ___VARIABLE_modelName___SortOrder,
    ) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let sortDescriptor = makeSortDescriptor(sortType: sortType, sortOrder: sortOrder)
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive
                },
                sortBy: [sortDescriptor]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetch sorted favorite ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Search

    public func search(query: String, includeArchived: Bool = false) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true)
                    },
                    sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
                )
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        (___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true)) &&
                            !___VARIABLE_modelVariableName___.isArchive
                    },
                    sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
                )
            }

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Search ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func searchSorted(
        query: String,
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: ___VARIABLE_modelName___SortOrder,
        includeArchived: Bool = false,
    ) -> Result<[___VARIABLE_modelName___], Error> {
        do {
            let sortDescriptor = makeSortDescriptor(sortType: sortType, sortOrder: sortOrder)

            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true)
                    },
                    sortBy: [sortDescriptor]
                )
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { ___VARIABLE_modelVariableName___ in
                        (___VARIABLE_modelVariableName___.name.localizedStandardContains(query) ||
                            (___VARIABLE_modelVariableName___.note?.localizedStandardContains(query) == true)) &&
                            !___VARIABLE_modelVariableName___.isArchive
                    },
                    sortBy: [sortDescriptor]
                )
            }

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Search sorted ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    // MARK: - Count Operations

    public func count(includeArchived: Bool = false) -> Result<Int, Error> {
        do {
            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>()
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { !$0.isArchive }
                )
            }
            let count = try context.fetchCount(descriptor)
            return .success(count)
        } catch {
            logError("Count ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
        }
    }

    public func countFavorites() -> Result<Int, Error> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isFavorite && !$0.isArchive }
            )
            let count = try context.fetchCount(descriptor)
            return .success(count)
        } catch {
            logError("Count favorite ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.fetchFailed)
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
        isArchive: Bool? = nil,
    ) {
        logData("Updating ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)'")

        if let name {
            ___VARIABLE_modelVariableName___.name = name
        }
        if let color {
            ___VARIABLE_modelVariableName___.colorData = .init(color: color)
        }
        if let date {
            ___VARIABLE_modelVariableName___.date = date
        }
        if let image {
            ___VARIABLE_modelVariableName___.imageData = image
        }
        if let note {
            ___VARIABLE_modelVariableName___.note = note
        }
        if let isFavorite {
            ___VARIABLE_modelVariableName___.isFavorite = isFavorite
        }
        if let isArchive {
            ___VARIABLE_modelVariableName___.isArchive = isArchive
        }
    }

    public func toggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, Error> {
        logData("Toggling favorite for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' (current: \(___VARIABLE_modelVariableName___.isFavorite))")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            ___VARIABLE_modelVariableName___.isFavorite.toggle()
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully toggled favorite for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Toggle favorite for ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    public func toggleArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, Error> {
        logData("Toggling archive for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' (current: \(___VARIABLE_modelVariableName___.isArchive))")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            ___VARIABLE_modelVariableName___.isArchive.toggle()
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully toggled archive for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Toggle archive for ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    public func incrementViewCount(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, Error> {
        logDebug("Incrementing view count for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' (current: \(___VARIABLE_modelVariableName___.viewCount))")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            ___VARIABLE_modelVariableName___.viewCount += 1
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDebug("Successfully incremented view count for ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Increment view count for ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }

    public func archive(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> Result<Void, Error> {
        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                ___VARIABLE_modelVariableName___.isArchive = true
            }
            try context.save()
            return .success(())
        } catch {
            logError("Archive ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    public func unarchive(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> Result<Void, Error> {
        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                ___VARIABLE_modelVariableName___.isArchive = false
            }
            try context.save()
            return .success(())
        } catch {
            logError("Unarchive ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
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
            logDeleted("___VARIABLE_modelName___ '\(___VARIABLE_modelVariableName___.name)' deleted successfully")
            logDebug("Deletion of ___VARIABLE_modelName___ '\(___VARIABLE_modelVariableName___.name)' took \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.deleteFailed)
        }
    }

    public func delete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> Result<Void, Error> {
        logData("Attempting to delete \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                context.delete(___VARIABLE_modelVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDeleted("\(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s deleted successfully in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete multiple ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    public func deleteAll(includeArchived: Bool = true) -> Result<Void, Error> {
        logData("Attempting to delete all ___VARIABLE_modelName___s (includeArchived: \(includeArchived))")
        let startTime = CFAbsoluteTimeGetCurrent()

        do {
            let descriptor = if includeArchived {
                FetchDescriptor<___VARIABLE_modelName___>()
            } else {
                FetchDescriptor<___VARIABLE_modelName___>(
                    predicate: #Predicate { !$0.isArchive }
                )
            }

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
                context.delete(___VARIABLE_modelVariableName___)
            }
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logDeleted("All \(___VARIABLE_modelPluralVariableName___.count) ___VARIABLE_modelName___s deleted successfully in \(String(format: "%.3f", duration))s")
            return .success(())
        } catch {
            logError("Delete all ___VARIABLE_modelName___s:", error: error)
            return .failure(SwiftDataError.batchOperationFailed)
        }
    }

    // MARK: - Validation

    public func exists(with id: UUID) -> Bool {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.id == id }
            )
            let count = try context.fetchCount(descriptor)
            return count > 0
        } catch {
            logError("Check if ___VARIABLE_modelName___ exists:", error: error)
            return false
        }
    }

    public func validate(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, Error> {
        guard !___VARIABLE_modelVariableName___.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .failure(SwiftDataError.validationFailed(reason: "Name cannot be empty"))
        }
        return .success(())
    }

    // MARK: - Duplicate Operations

    public func duplicate(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<___VARIABLE_modelName___, Error> {
        logData("Attempting to duplicate ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)'")
        let startTime = CFAbsoluteTimeGetCurrent()

        let duplicatedProduct = ___VARIABLE_modelName___(
            name: "\(___VARIABLE_modelVariableName___.name) Copy",
            color: ___VARIABLE_modelVariableName___.color,
            date: Date(),
            image: ___VARIABLE_modelVariableName___.imageData,
            note: ___VARIABLE_modelVariableName___.note,
            isFavorite: false,
            isArchive: false,
            viewCount: 0,
        )

        do {
            context.insert(duplicatedProduct)
            try context.save()
            let duration = CFAbsoluteTimeGetCurrent() - startTime
            logSuccess("Successfully duplicated ___VARIABLE_modelName___: '\(___VARIABLE_modelVariableName___.name)' -> '\(duplicatedProduct.name)' in \(String(format: "%.3f", duration))s")
            return .success(duplicatedProduct)
        } catch {
            logError("Duplicate ___VARIABLE_modelName___:", error: error)
            return .failure(SwiftDataError.saveFailed)
        }
    }
}
