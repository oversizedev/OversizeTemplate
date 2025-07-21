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
        note: String? = nil,
        calories: Double = 0,
        protein: Double = 0,
        carbs: Double = 0,
        fat: Double = 0,
        fiber: Double? = nil,
        sugar: Double? = nil,
        sodium: Double? = nil,
        servingSize: String = "100g",
        category: String = "General",
        brand: String? = nil,
        barcode: String? = nil
    ) -> Result<___VARIABLE_modelName___, AppError> {
        let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___ = .init(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            fiber: fiber,
            sugar: sugar,
            sodium: sodium,
            servingSize: servingSize,
            category: category,
            brand: brand,
            barcode: barcode
        )

        do {
            context.insert(___VARIABLE_modelVariableName___)
            try context.save()
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Save for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func update___VARIABLE_modelName___(
        ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        isArchive: Bool? = nil,
        calories: Double? = nil,
        protein: Double? = nil,
        carbs: Double? = nil,
        fat: Double? = nil,
        fiber: Double? = nil,
        sugar: Double? = nil,
        sodium: Double? = nil,
        servingSize: String? = nil,
        category: String? = nil,
        brand: String? = nil,
        barcode: String? = nil
    ) {
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
        if let calories {
            ___VARIABLE_modelVariableName___.calories = calories
        }
        if let protein {
            ___VARIABLE_modelVariableName___.protein = protein
        }
        if let carbs {
            ___VARIABLE_modelVariableName___.carbs = carbs
        }
        if let fat {
            ___VARIABLE_modelVariableName___.fat = fat
        }
        if let fiber {
            ___VARIABLE_modelVariableName___.fiber = fiber
        }
        if let sugar {
            ___VARIABLE_modelVariableName___.sugar = sugar
        }
        if let sodium {
            ___VARIABLE_modelVariableName___.sodium = sodium
        }
        if let servingSize {
            ___VARIABLE_modelVariableName___.servingSize = servingSize
        }
        if let category {
            ___VARIABLE_modelVariableName___.category = category
        }
        if let brand {
            ___VARIABLE_modelVariableName___.brand = brand
        }
        if let barcode {
            ___VARIABLE_modelVariableName___.barcode = barcode
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
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { !$0.isArchive },
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
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
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
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

            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)

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
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
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
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___(id: UUID) -> Result<___VARIABLE_modelName___, AppError> {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.id == id }
            )
            guard let ___VARIABLE_modelVariableName___ = try context.fetch(descriptor).first else {
                return .failure(AppError.coreData(type: .fetchItems))
            }
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
}
