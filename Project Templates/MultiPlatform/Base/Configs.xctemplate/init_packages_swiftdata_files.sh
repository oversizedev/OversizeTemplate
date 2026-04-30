#!/bin/bash

rm -rf Packages/Database/Sources/Database/Database.swift

# Create directory structure
mkdir -p Packages/Database/Sources/Database/Injection
mkdir -p Packages/Database/Sources/Database/Models/Domain
mkdir -p Packages/Database/Sources/Database/Models/Entity
mkdir -p Packages/Database/Sources/Database/Services

# Create Injection.swift
cat <<EOF >Packages/Database/Sources/Database/Injection/Injection.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// Injection.swift, created on $(date +%d.%m.%Y)
//

import FactoryKit
import Foundation
import OversizeCore
import SwiftData

public extension Container {
    var modelContainerService: Factory<ModelContainer> {
        self {
            let schema = Schema([___VARIABLE_modelName___Entity.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            do {
                return try ModelContainer(for: schema, configurations: [config])
            } catch {
                logError("Could not create ModelContainer:", error: error)
                let fallback = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                return try! ModelContainer(for: schema, configurations: [fallback])
            }
        }.singleton
    }

    var storageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            ___VARIABLE_modelName___StorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}
EOF

# Create Domain model
cat <<EOF >Packages/Database/Sources/Database/Models/Domain/___VARIABLE_modelName___.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// ___VARIABLE_modelName___.swift, created on $(date +%d.%m.%Y)
//

import OversizeCore
import SwiftUI

public struct ___VARIABLE_modelName___: Identifiable, Equatable, Hashable, Sendable {
    public let id: UUID
    public let imageData: Data?
    public let name: String
    public let color: Color
    public let date: Date
    public let note: String?
    public let isFavorite: Bool
    public let isArchive: Bool

    public var image: Image? {
        imageData.flatMap { Image(data: \$0) }
    }

    public init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        name: String,
        color: Color,
        date: Date,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false
    ) {
        self.id = id
        self.imageData = imageData
        self.name = name
        self.color = color
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
    }
}

public extension ___VARIABLE_modelName___ {
    init(from entity: ___VARIABLE_modelName___Entity) {
        self.init(
            id: entity.id,
            imageData: entity.imageData,
            name: entity.name ?? "",
            color: entity.colorData?.color ?? .clear,
            date: entity.date ?? Date(),
            note: entity.note,
            isFavorite: entity.isFavorite ?? false,
            isArchive: entity.isArchive ?? false
        )
    }
}
EOF

# Create Entity model
cat <<EOF >Packages/Database/Sources/Database/Models/Entity/___VARIABLE_modelName___Entity.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// ___VARIABLE_modelName___Entity.swift, created on $(date +%d.%m.%Y)
//

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_modelName___Entity {
    @Attribute(.unique)
    public private(set) var id: UUID = UUID()

    public var name: String?

    public var colorData: ColorData?

    @Attribute(.externalStorage)
    public var imageData: Data?

    public var date: Date?

    public var note: String?

    public var isFavorite: Bool?

    public var isArchive: Bool?

    public init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        date: Date,
        image: Data?,
        note: String?,
        isFavorite: Bool,
        isArchive: Bool
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.date = date
        imageData = image
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
    }
}

public extension ___VARIABLE_modelName___Entity {
    convenience init(from domain: ___VARIABLE_modelName___) {
        self.init(
            id: domain.id,
            name: domain.name,
            color: domain.color,
            date: domain.date,
            image: domain.imageData,
            note: domain.note,
            isFavorite: domain.isFavorite,
            isArchive: domain.isArchive
        )
    }
}
EOF

# Create StorageService
cat <<EOF >Packages/Database/Sources/Database/Services/___VARIABLE_modelName___StorageService.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// ___VARIABLE_modelName___StorageService.swift, created on $(date +%d.%m.%Y)
//

import OversizeCore
import SwiftData
import SwiftUI

@ModelActor
public actor ___VARIABLE_modelName___StorageService {
    public func save(
        id: UUID = UUID(),
        name: String,
        color: Color,
        date: Date = Date(),
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false
    ) throws -> ___VARIABLE_modelName___ {
        let entity = ___VARIABLE_modelName___Entity(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note,
            isFavorite: isFavorite,
            isArchive: isArchive
        )
        modelContext.insert(entity)
        do {
            try modelContext.save()
            return ___VARIABLE_modelName___(from: entity)
        } catch {
            logError("Save ___VARIABLE_modelName___ failed:", error: error)
            throw PersistenceError.saveFailed
        }
    }

    public func fetch() throws -> [___VARIABLE_modelName___] {
        do {
            let descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(sortBy: [SortDescriptor(\\.date, order: .reverse)])
            return try modelContext.fetch(descriptor).map { ___VARIABLE_modelName___(from: \$0) }
        } catch {
            logError("Fetch ___VARIABLE_modelName___ failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    public func fetchById(id: UUID) throws -> ___VARIABLE_modelName___ {
        let predicate = #Predicate<___VARIABLE_modelName___Entity> { \$0.id == id }
        var descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(predicate: predicate)
        descriptor.fetchLimit = 1
        do {
            guard let entity = try modelContext.fetch(descriptor).first else {
                throw PersistenceError.itemNotFound
            }
            return ___VARIABLE_modelName___(from: entity)
        } catch {
            logError("Fetch ___VARIABLE_modelName___ by id failed:", error: error)
            throw PersistenceError.fetchFailed
        }
    }

    public func update(
        id: UUID,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool? = nil,
        isArchive: Bool? = nil
    ) throws -> ___VARIABLE_modelName___ {
        let predicate = #Predicate<___VARIABLE_modelName___Entity> { \$0.id == id }
        var descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(predicate: predicate)
        descriptor.fetchLimit = 1
        do {
            guard let entity = try modelContext.fetch(descriptor).first else {
                throw PersistenceError.itemNotFound
            }
            if let name { entity.name = name }
            if let color { entity.colorData = .init(color: color) }
            if let date { entity.date = date }
            if let image { entity.imageData = image }
            if let note { entity.note = note }
            if let isFavorite { entity.isFavorite = isFavorite }
            if let isArchive { entity.isArchive = isArchive }
            try modelContext.save()
            return ___VARIABLE_modelName___(from: entity)
        } catch {
            logError("Update ___VARIABLE_modelName___ failed:", error: error)
            throw PersistenceError.updateFailed
        }
    }

    public func delete(id: UUID) throws {
        let predicate = #Predicate<___VARIABLE_modelName___Entity> { \$0.id == id }
        var descriptor = FetchDescriptor<___VARIABLE_modelName___Entity>(predicate: predicate)
        descriptor.fetchLimit = 1
        do {
            guard let entity = try modelContext.fetch(descriptor).first else {
                throw PersistenceError.itemNotFound
            }
            modelContext.delete(entity)
            try modelContext.save()
        } catch {
            logError("Delete ___VARIABLE_modelName___ failed:", error: error)
            throw PersistenceError.deleteFailed
        }
    }
}
EOF

echo "SwiftData files generated successfully!"
echo "Created:"
echo "- Injection/Injection.swift"
echo "- Models/Domain/___VARIABLE_modelName___.swift"
echo "- Models/Entity/___VARIABLE_modelName___Entity.swift"
echo "- Services/___VARIABLE_modelName___StorageService.swift"
