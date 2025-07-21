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

    // MARK: - CRUD Operations

    public func add___VARIABLE_modelName___(
        id: UUID = UUID(),
        name: String,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil
    ) -> Result<___VARIABLE_modelName___, AppError> {
        // Validation
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return .failure(AppError.validation(message: "Name cannot be empty"))
        }
        
        let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___ = .init(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note
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
        isArchive: Bool? = nil
    ) -> Result<___VARIABLE_modelName___, AppError> {
        // Validation
        if let name, name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return .failure(AppError.validation(message: "Name cannot be empty"))
        }
        
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
        
        do {
            try context.save()
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Update for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> Result<Void, AppError> {
        context.delete(___VARIABLE_modelVariableName___)
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Error deleting ___VARIABLE_modelVariableName___:", error: error)
            return .failure(AppError.coreData(type: .deletingItem))
        }
    }

    public func duplicate___VARIABLE_modelName___(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        withNewName newName: String? = nil
    ) -> Result<___VARIABLE_modelName___, AppError> {
        let duplicatedName = newName ?? "\(___VARIABLE_modelVariableName___.name) Copy"
        
        return add___VARIABLE_modelName___(
            name: duplicatedName,
            color: ___VARIABLE_modelVariableName___.color,
            date: Date(),
            image: ___VARIABLE_modelVariableName___.imageData,
            note: ___VARIABLE_modelVariableName___.note
        )
    }

    // MARK: - Fetch Operations

    public func fetch___VARIABLE_modelName___(
        filterType: ___VARIABLE_modelName___ListFilterType = .standard,
        searchTerm: String = "",
        sortType: ___VARIABLE_modelName___ListSortType = .dateCreated,
        sortOrder: ___VARIABLE_modelName___ListSortOrder = .descending
    ) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let predicate = buildPredicate(filterType: filterType, searchTerm: searchTerm)
            let sortDescriptor = buildSortDescriptor(sortType: sortType, order: sortOrder)
            
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: predicate,
                sortBy: [sortDescriptor]
            )
            
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            logError("Fetching ___VARIABLE_modelName___:", error: error)
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
            
            // Increment view count
            ___VARIABLE_modelVariableName___.viewCount += 1
            try context.save()
            
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    public func fetch___VARIABLE_modelName___ByDateRange(
        from: Date,
        to: Date,
        filterType: ___VARIABLE_modelName___ListFilterType = .standard
    ) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let predicate: Predicate<___VARIABLE_modelName___>
            
            switch filterType {
            case .standard:
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.date >= from && ___VARIABLE_modelVariableName___.date <= to && !___VARIABLE_modelVariableName___.isArchive
                }
            case .archived:
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.date >= from && ___VARIABLE_modelVariableName___.date <= to && ___VARIABLE_modelVariableName___.isArchive
                }
            case .favorites:
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.date >= from && ___VARIABLE_modelVariableName___.date <= to && ___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive
                }
            }
            
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: predicate,
                sortBy: [SortDescriptor(\___VARIABLE_modelName___.date, order: .reverse)]
            )
            
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    // MARK: - Toggle Operations

    public func toggleFavorite___VARIABLE_modelName___(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    ) -> Result<___VARIABLE_modelName___, AppError> {
        ___VARIABLE_modelVariableName___.isFavorite.toggle()
        
        do {
            try context.save()
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Toggle favorite for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func toggleArchive___VARIABLE_modelName___(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    ) -> Result<___VARIABLE_modelName___, AppError> {
        ___VARIABLE_modelVariableName___.isArchive.toggle()
        
        do {
            try context.save()
            return .success(___VARIABLE_modelVariableName___)
        } catch {
            logError("Toggle archive for ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    // MARK: - Batch Operations

    public func batchDelete___VARIABLE_modelName___(
        _ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
    ) -> Result<Void, AppError> {
        ___VARIABLE_modelPluralVariableName___.forEach { context.delete($0) }
        
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Batch delete ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .deletingItem))
        }
    }

    public func batchToggleFavorite___VARIABLE_modelName___(
        _ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___],
        isFavorite: Bool
    ) -> Result<Void, AppError> {
        ___VARIABLE_modelPluralVariableName___.forEach { $0.isFavorite = isFavorite }
        
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Batch toggle favorite ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func batchToggleArchive___VARIABLE_modelName___(
        _ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___],
        isArchive: Bool
    ) -> Result<Void, AppError> {
        ___VARIABLE_modelPluralVariableName___.forEach { $0.isArchive = isArchive }
        
        do {
            try context.save()
            return .success(())
        } catch {
            logError("Batch toggle archive ___VARIABLE_modelName___:", error: error)
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    // MARK: - Validation

    public func validate___VARIABLE_modelName___(
        name: String,
        excludingId: UUID? = nil
    ) -> Result<Void, AppError> {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            return .failure(AppError.validation(message: "Name cannot be empty"))
        }
        
        guard trimmedName.count <= 100 else {
            return .failure(AppError.validation(message: "Name cannot exceed 100 characters"))
        }
        
        // Check for duplicates
        do {
            let predicate: Predicate<___VARIABLE_modelName___>
            if let excludingId {
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.name.lowercased() == trimmedName.lowercased() && ___VARIABLE_modelVariableName___.id != excludingId
                }
            } else {
                predicate = #Predicate { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelVariableName___.name.lowercased() == trimmedName.lowercased()
                }
            }
            
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(predicate: predicate)
            let existingItems = try context.fetch(descriptor)
            
            if !existingItems.isEmpty {
                return .failure(AppError.validation(message: "A ___VARIABLE_modelVariableName___ with this name already exists"))
            }
            
            return .success(())
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    // MARK: - Private Helpers

    private func buildPredicate(
        filterType: ___VARIABLE_modelName___ListFilterType,
        searchTerm: String
    ) -> Predicate<___VARIABLE_modelName___>? {
        let trimmedSearchTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch (filterType, trimmedSearchTerm.isEmpty) {
        case (.standard, true):
            return #Predicate { !$0.isArchive }
        case (.standard, false):
            return #Predicate { ___VARIABLE_modelVariableName___ in
                !___VARIABLE_modelVariableName___.isArchive && ___VARIABLE_modelVariableName___.name.lowercased().contains(trimmedSearchTerm)
            }
        case (.archived, true):
            return #Predicate { $0.isArchive }
        case (.archived, false):
            return #Predicate { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelVariableName___.isArchive && ___VARIABLE_modelVariableName___.name.lowercased().contains(trimmedSearchTerm)
            }
        case (.favorites, true):
            return #Predicate { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive
            }
        case (.favorites, false):
            return #Predicate { ___VARIABLE_modelVariableName___ in
                ___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive && ___VARIABLE_modelVariableName___.name.lowercased().contains(trimmedSearchTerm)
            }
        }
    }

    private func buildSortDescriptor(
        sortType: ___VARIABLE_modelName___ListSortType,
        order: ___VARIABLE_modelName___ListSortOrder
    ) -> SortDescriptor<___VARIABLE_modelName___> {
        let sortOrder: SortOrder = order == .ascending ? .forward : .reverse
        
        switch sortType {
        case .name:
            return SortDescriptor(\___VARIABLE_modelName___.name, order: sortOrder)
        case .dateCreated:
            return SortDescriptor(\___VARIABLE_modelName___.date, order: sortOrder)
        case .viewCount:
            return SortDescriptor(\___VARIABLE_modelName___.viewCount, order: sortOrder)
        case .isFavorite:
            return SortDescriptor(\___VARIABLE_modelName___.isFavorite, order: sortOrder)
        }
    }
}
