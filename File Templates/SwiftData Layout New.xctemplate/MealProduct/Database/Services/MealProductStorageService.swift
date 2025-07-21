//
// Copyright © 2025 Alexander Romanov
// MealProductStorageService.swift, created on 09.07.2025
//

import OversizeCore
import OversizeModels
import SwiftData
import SwiftUI

public actor MealProductStorageService: ModelActor {
    public let modelContainer: ModelContainer
    public let modelExecutor: any ModelExecutor
    let context: ModelContext

    public init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    public func addMealProduct(
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
    ) -> Result<MealProduct, AppError> {
        let mealProduct: MealProduct = .init(
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
            context.insert(mealProduct)
            try context.save()
            return .success(mealProduct)
        } catch {
            logError("Save for MealProduct:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func updateMealProduct(
        mealProduct: MealProduct,
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
            mealProduct.name = name
        }
        if let color {
            mealProduct.colorData = .init(color: color)
        }
        if let date {
            mealProduct.date = date
        }
        if let image {
            mealProduct.imageData = image
        }
        if let note {
            mealProduct.note = note
        }
        if let isFavorite {
            mealProduct.isFavorite = isFavorite
        }
        if let isArchive {
            mealProduct.isArchive = isArchive
        }
        if let calories {
            mealProduct.calories = calories
        }
        if let protein {
            mealProduct.protein = protein
        }
        if let carbs {
            mealProduct.carbs = carbs
        }
        if let fat {
            mealProduct.fat = fat
        }
        if let fiber {
            mealProduct.fiber = fiber
        }
        if let sugar {
            mealProduct.sugar = sugar
        }
        if let sodium {
            mealProduct.sodium = sodium
        }
        if let servingSize {
            mealProduct.servingSize = servingSize
        }
        if let category {
            mealProduct.category = category
        }
        if let brand {
            mealProduct.brand = brand
        }
        if let barcode {
            mealProduct.barcode = barcode
        }
    }

    public func deleteMealProduct(_ mealProduct: MealProduct) {
        context.delete(mealProduct)
        do {
            try context.save()

        } catch {
            logError("Error deleting mealProduct:", error: error)
        }
    }

    public func fetchMealProduct() -> Result<[MealProduct], AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { !$0.isArchive },
                sortBy: [SortDescriptor(\MealProduct.date, order: .reverse)]
            )
            let mealProducts = try context.fetch(descriptor)
            return .success(mealProducts)
        } catch {
            logError("Fetching MealProduct:", error: error)
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchMealProductByDateRange(from: Date, to: Date, withArchive: Bool = false) -> Result<[MealProduct], AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { MealProduct in
                    if withArchive {
                        MealProduct.date >= from && MealProduct.date <= to
                    } else {
                        MealProduct.date >= from && MealProduct.date <= to && !MealProduct.isArchive
                    }
                },
                sortBy: [SortDescriptor(\MealProduct.date, order: .reverse)]
            )
            let mealProducts = try context.fetch(descriptor)
            return .success(mealProducts)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchMealProductForDate(_ date: Date) -> Result<[MealProduct], AppError> {
        do {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            guard let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) else {
                logError("Failed to calculate endOfDay for date: \(date)")
                return .failure(AppError.coreData(type: .fetchItems))
            }

            logInfo("Date range for MealProducts: \(startOfDay) to \(endOfDay)")

            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { MealProduct in
                    MealProduct.date >= startOfDay && MealProduct.date < endOfDay && !MealProduct.isArchive
                },
                sortBy: [SortDescriptor(\MealProduct.date)]
            )

            let mealProducts = try context.fetch(descriptor)
            return .success(mealProducts)

        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchFavoriteMealProduct() -> Result<[MealProduct], AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { MealProduct in
                    MealProduct.isFavorite && !MealProduct.isArchive
                },
                sortBy: [SortDescriptor(\MealProduct.date, order: .reverse)]
            )
            let mealProducts = try context.fetch(descriptor)
            return .success(mealProducts)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchArchivedMealProduct() -> Result<[MealProduct], AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { $0.isArchive },
                sortBy: [SortDescriptor(\MealProduct.date, order: .reverse)]
            )
            let mealProducts = try context.fetch(descriptor)
            return .success(mealProducts)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchMealProduct(id: UUID) -> Result<MealProduct, AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { $0.id == id }
            )
            guard let mealProduct = try context.fetch(descriptor).first else {
                return .failure(AppError.coreData(type: .fetchItems))
            }
            return .success(mealProduct)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
}
