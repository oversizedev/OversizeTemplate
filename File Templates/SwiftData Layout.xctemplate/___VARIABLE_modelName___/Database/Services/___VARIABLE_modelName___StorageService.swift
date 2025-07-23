//
// Copyright © 2025 Alexander Romanov
// ___VARIABLE_modelName___StorageService.swift, created on 09.07.2025
//

import OversizeCore
import OversizeModels
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

    public func add___VARIABLE_modelName___(
        id: UUID,
        name: String,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil
    ) -> Result<___VARIABLE_modelName___, AppError> {
        let ___VARIABLE_modelName___: ___VARIABLE_modelName___ = .init(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note
        )

        do {
            context.insert(___VARIABLE_modelName___)
            try context.save()
            return .success(___VARIABLE_modelName___)
        } catch {
            logError("Save for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func update___VARIABLE_modelName___(
        ___VARIABLE_modelName___: ___VARIABLE_modelName___,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        isArchive: Bool? = nil
    ) {
        if let name {
            ___VARIABLE_modelName___.name = name
        }
        if let color {
            ___VARIABLE_modelName___.colorData = .init(color: color)
        }
        if let date {
            ___VARIABLE_modelName___.date = date
        }
        if let image {
            ___VARIABLE_modelName___.imageData = image
        }
        if let note {
            ___VARIABLE_modelName___.note = note
        }
        if let isFavorite {
            ___VARIABLE_modelName___.isFavorite = isFavorite
        }
        if let isArchive {
            ___VARIABLE_modelName___.isArchive = isArchive
        }
    }

    public func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        context.delete(___VARIABLE_modelVariableName___)
        do {
            try context.save()
        } catch {
            logError("Error deleting ___VARIABLE_modelVariableName___:", error: error)
        }
    }

    public func fetch___VARIABLE_modelName___() -> Result<[___VARIABLE_modelName___], AppError> {
        fetch___VARIABLE_modelName___(sortBy: .date)
    }
    
    public func fetch___VARIABLE_modelName___(sortBy: ___VARIABLE_modelName___SortType) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let sortDescriptor = switch sortBy {
            case .name:
                SortDescriptor(\___VARIABLE_modelName___.name, order: .forward)
            case .date:
                SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)
            case .favorite:
                SortDescriptor(\___VARIABLE_modelName___.isFavorite, order: .reverse)
            }
            
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { !$0.isArchive },
                sortBy: [sortDescriptor]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            logError("Fetching ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___ByDateRange(from: Date, to: Date, withArchive: Bool = false) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelName___ in
                    if withArchive {
                        ___VARIABLE_modelName___.date >= from && ___VARIABLE_modelName___.date <= to
                    } else {
                        ___VARIABLE_modelName___.date >= from && ___VARIABLE_modelName___.date <= to && !___VARIABLE_modelName___.isArchive
                    }
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___ForDate(_ date: Date) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
                logError("Failed to calculate endOfDay for date: \(date)")
                return .failure(AppError.coreData(type: .fetchItems))
            }

            logInfo("Date range for ___VARIABLE_modelName___s: \(startOfDay) to \(endOfDay)")

            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelName___ in
                    ___VARIABLE_modelName___.date >= startOfDay && ___VARIABLE_modelName___.date < endOfDay && !___VARIABLE_modelName___.isArchive
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date)]
            )

            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)

        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchFavorite___VARIABLE_modelName___() -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { ___VARIABLE_modelName___ in
                    ___VARIABLE_modelName___.isFavorite && !___VARIABLE_modelName___.isArchive
                },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchArchived___VARIABLE_modelName___() -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isArchive },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___(id: UUID) -> Result<___VARIABLE_modelName___, AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.id == id }
            )
            guard let ___VARIABLE_modelName___ = try context.fetch(descriptor).first else {
                return .failure(AppError.coreData(type: .fetchItems))
            }
            return .success(___VARIABLE_modelName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
}
