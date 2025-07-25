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
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func update___VARIABLE_modelName___(
        _ ___VARIABLE_modelName___: ___VARIABLE_modelName___,
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
        
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }

    public func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        context.delete(___VARIABLE_modelVariableName___)
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }
    
    public func incrementViewCount(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___.viewCount += 1
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }

    // MARK: - Fetch Operations

    public func fetch___VARIABLE_modelName___(
        sortType: ___VARIABLE_modelName___SortType = .date,
        sortOrder: SortOrder = .reverse,
        filterType: ___VARIABLE_modelName___FilterType = .all,
        searchTerm: String? = nil
    ) -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            var predicate: Predicate<___VARIABLE_modelName___>?
            
            // Apply filters
            switch filterType {
            case .all:
                predicate = #Predicate { !$0.isArchive }
            case .favorites:
                predicate = #Predicate { $0.isFavorite && !$0.isArchive }
            case .archived:
                predicate = #Predicate { $0.isArchive }
            case .recent:
                let recentDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
                predicate = #Predicate { $0.date >= recentDate && !$0.isArchive }
            }
            
            // Add search term if provided
            if let searchTerm, !searchTerm.isEmpty {
                let existingPredicate = predicate
                if let existingPredicate {
                    predicate = #Predicate<___VARIABLE_modelName___> { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.name.localizedStandardContains(searchTerm) && 
                        !___VARIABLE_modelVariableName___.isArchive &&
                        (filterType == .all || 
                         (filterType == .favorites && ___VARIABLE_modelVariableName___.isFavorite) ||
                         (filterType == .archived && ___VARIABLE_modelVariableName___.isArchive) ||
                         (filterType == .recent && ___VARIABLE_modelVariableName___.date >= Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()))
                    }
                } else {
                    predicate = #Predicate<___VARIABLE_modelName___> { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelVariableName___.name.localizedStandardContains(searchTerm)
                    }
                }
            }
            
            // Apply sorting
            var sortDescriptor: SortDescriptor<___VARIABLE_modelName___>
            switch sortType {
            case .name:
                sortDescriptor = SortDescriptor(\___VARIABLE_modelName___.name, order: sortOrder)
            case .date:
                sortDescriptor = SortDescriptor(\___VARIABLE_modelName___.date, order: sortOrder)
            case .favorite:
                sortDescriptor = SortDescriptor(\___VARIABLE_modelName___.isFavorite, order: sortOrder)
            case .viewCount:
                sortDescriptor = SortDescriptor(\___VARIABLE_modelName___.viewCount, order: sortOrder)
            }
            
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: predicate,
                sortBy: [sortDescriptor]
            )
            
            let ___VARIABLE_modelPluralVariableName___ = try context.fetch(descriptor)
            return .success(___VARIABLE_modelPluralVariableName___)
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }

    // MARK: - Legacy Fetch Methods (for backward compatibility)

    public func fetch___VARIABLE_modelName___() -> Result<[___VARIABLE_modelName___], AppError> {
        return fetch___VARIABLE_modelName___(sortType: .date, sortOrder: .reverse, filterType: .all)
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
                return .failure(AppError.coreData(type: .fetchItems))
            }

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
        return fetch___VARIABLE_modelName___(filterType: .favorites)
    }

    public func fetchArchived___VARIABLE_modelName___() -> Result<[___VARIABLE_modelName___], AppError> {
        return fetch___VARIABLE_modelName___(filterType: .archived)
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
    
    // MARK: - Batch Operations
    
    public func batchDelete___VARIABLE_modelName___(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) {
        for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
            context.delete(___VARIABLE_modelVariableName___)
        }
        
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }
    
    public func batchArchive___VARIABLE_modelName___(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) {
        for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
            ___VARIABLE_modelVariableName___.isArchive = true
        }
        
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }
    
    public func batchUnarchive___VARIABLE_modelName___(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) {
        for ___VARIABLE_modelVariableName___ in ___VARIABLE_modelPluralVariableName___ {
            ___VARIABLE_modelVariableName___.isArchive = false
        }
        
        do {
            try context.save()
        } catch {
            // Handle error silently or add proper error handling
        }
    }
    
    // MARK: - Search Operations
    
    public func search___VARIABLE_modelName___(term: String, limit: Int = 50) -> Result<[___VARIABLE_modelName___], AppError> {
        guard !term.isEmpty else {
            return fetch___VARIABLE_modelName___()
        }
        
        return fetch___VARIABLE_modelName___(searchTerm: term)
    }
    
    // MARK: - Statistics
    
    public func get___VARIABLE_modelName___Count() -> Int {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { !$0.isArchive }
            )
            return try context.fetchCount(descriptor)
        } catch {
            return 0
        }
    }
    
    public func getFavorite___VARIABLE_modelName___Count() -> Int {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___>(
                predicate: #Predicate { $0.isFavorite && !$0.isArchive }
            )
            return try context.fetchCount(descriptor)
        } catch {
            return 0
        }
    }
}
