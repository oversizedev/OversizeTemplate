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
        note: String? = nil
    ) -> Result<MealProduct, AppError> {
        let MealProduct: MealProduct = .init(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note
        )

        do {
            context.insert(MealProduct)
            try context.save()
            return .success(MealProduct)
        } catch {
            logError("Save for MealProduct:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func updateMealProduct(
        MealProduct: MealProduct,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        isArchive: Bool? = nil
    ) {
        if let name {
            MealProduct.name = name
        }
        if let color {
            MealProduct.colorData = .init(color: color)
        }
        if let date {
            MealProduct.date = date
        }
        if let image {
            MealProduct.imageData = image
        }
        if let note {
            MealProduct.note = note
        }
        if let isFavorite {
            MealProduct.isFavorite = isFavorite
        }
        if let isArchive {
            MealProduct.isArchive = isArchive
        }
    }

    public func deleteMealProduct(_ account: MealProduct) {
        context.delete(account)
        do {
            try context.save()

        } catch {
            logError("Error deleting account:", error: error)
        }
    }

    public func fetchMealProduct() -> Result<[MealProduct], AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { !$0.isArchive },
                sortBy: [SortDescriptor(\MealProduct.date, order: .reverse)]
            )
            let MealProducts = try context.fetch(descriptor)
            return .success(MealProducts)
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
            let MealProducts = try context.fetch(descriptor)
            return .success(MealProducts)
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

            let MealProducts = try context.fetch(descriptor)
            return .success(MealProducts)

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
            let MealProducts = try context.fetch(descriptor)
            return .success(MealProducts)
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
            let MealProducts = try context.fetch(descriptor)
            return .success(MealProducts)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetchMealProduct(id: UUID) -> Result<MealProduct, AppError> {
        do {
            let descriptor = FetchDescriptor<MealProduct>(
                predicate: #Predicate { $0.id == id }
            )
            guard let MealProduct = try context.fetch(descriptor).first else {
                return .failure(AppError.coreData(type: .fetchItems))
            }
            return .success(MealProduct)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
}
