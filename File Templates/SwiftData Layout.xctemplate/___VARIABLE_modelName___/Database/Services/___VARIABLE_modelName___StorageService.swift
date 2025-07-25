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
    ) async -> Result<___VARIABLE_modelName___, AppError> {
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
    ) async -> Result<Void, AppError> {
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

        do {
            try context.save()
            return .success(())
        } catch {
            logError("Update for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func delete(_ ___VARIABLE_modelName___: ___VARIABLE_modelName___) async -> Result<Void, AppError> {
        context.delete(___VARIABLE_modelName___)
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Error deleting ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func fetch___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { !$0.isArchive },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            logError("Fetching ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchFavorite___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
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
            logError("Fetching favorite ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchArchived___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isArchive },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelName___s = try context.fetch(descriptor)
            return .success(___VARIABLE_modelName___s)
        } catch {
            logError("Fetching archived ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___(id: UUID) async -> Result<___VARIABLE_modelName___, AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.id == id }
            )
            guard let ___VARIABLE_modelName___ = try context.fetch(descriptor).first else {
                return .failure(AppError.coreData(type: .fetchItems))
            }
            
            // Increment view count
            ___VARIABLE_modelName___.viewCount += 1
            try context.save()
            
            return .success(___VARIABLE_modelName___)
        } catch {
            logError("Fetching ___VARIABLE_modelName___ by ID:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___ByDateRange(from: Date, to: Date, withArchive: Bool = false) async -> Result<[___VARIABLE_modelName___], AppError> {
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
            logError("Fetching ___VARIABLE_modelName___ by date range:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___ForDate(_ date: Date) async -> Result<[___VARIABLE_modelName___], AppError> {
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
            logError("Fetching ___VARIABLE_modelName___ for date:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func toggleFavorite(_ ___VARIABLE_modelName___: ___VARIABLE_modelName___) async -> Result<Void, AppError> {
        ___VARIABLE_modelName___.isFavorite.toggle()
        
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Toggle favorite for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func toggleArchive(_ ___VARIABLE_modelName___: ___VARIABLE_modelName___) async -> Result<Void, AppError> {
        ___VARIABLE_modelName___.isArchive.toggle()
        
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Toggle archive for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }
}
