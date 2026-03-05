#!/bin/bash

rm -rf Packages/Database/Sources/Database/Database.swift

# Create directory structure
mkdir -p Packages/Database/Sources/Database/Injection
mkdir -p Packages/Database/Sources/Database/Models
mkdir -p Packages/Database/Sources/Database/Services

# Create Injection.swift
cat <<EOF >Packages/Database/Sources/Database/Injection/Injection.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// Injection.swift, created on $(date +%d.%m.%Y)
//

import FactoryKit
import Foundation
import SwiftData

public extension Container {
    var modelContainerService: Factory<ModelContainer> {
        self {
            let sharedModelContainer: ModelContainer = {
                let schema = Schema([
                    ___VARIABLE_modelName___.self,
                ])
                let modelConfiguration = ModelConfiguration(
                    schema: schema,
                    isStoredInMemoryOnly: false,
                )

                do {
                    return try ModelContainer(
                        for: schema,
                        configurations: [modelConfiguration],
                    )
                } catch {
                    fatalError("Could not create ModelContainer: \(error)")
                }
            }()

            return sharedModelContainer

        }.singleton
    }

    var dataStorageService: Factory<___VARIABLE_modelName___StorageService> {
        self {
            ___VARIABLE_modelName___StorageService(modelContainer: self.modelContainerService())
        }.singleton
    }
}
EOF

# Create ___VARIABLE_modelName___.swift
cat <<EOF >Packages/Database/Sources/Database/Models/___VARIABLE_modelName___.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// ___VARIABLE_modelName___.swift, created on $(date +%d.%m.%Y)
//

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_modelName___: Identifiable, Equatable, @unchecked Sendable {
    @Attribute(.unique) public private(set) var id: UUID

    public var name: String

    public var colorData: ColorData

    @Attribute(.externalStorage) public var imageData: Data?

    public var date: Date

    public var note: String?

    public var isFavorite: Bool

    public var isArchive: Bool

    public init(
        id: UUID,
        name: String,
        color: Color,
        date: Date,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
        imageData = image
    }
}

public extension ___VARIABLE_modelName___ {
    static var all: FetchDescriptor<___VARIABLE_modelName___> {
        FetchDescriptor(
            sortBy: [SortDescriptor(
                \___VARIABLE_modelName___.name,
                order: .reverse,
            )]
        )
    }

    var color: Color {
        colorData.color
    }

    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }
}
EOF

# Create AccountStorageService.swift
cat <<EOF >Packages/Database/Sources/Database/Services/AccountStorageService.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// AccountStorageService.swift, created on $(date +%d.%m.%Y)
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
    ) -> Result<___VARIABLE_modelName___, AppError> {
        let account: ___VARIABLE_modelName___ = .init(
            id: id,
            name: name,
            color: color,
            date: date,
            image: image,
            note: note,
        )

        do {
            context.insert(account)
            try context.save()
            return .success(account)
        } catch {
            return .failure(AppError.coreData(type: .savingItem))
        }
    }

    public func update___VARIABLE_modelName___(
        account: ___VARIABLE_modelName___,
        name: String? = nil,
        color: Color? = nil,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
    ) {
        if let name {
            account.name = name
        }
        if let color {
            account.colorData = .init(color: color)
        }
        if let date {
            account.date = date
        }
        if let image {
            account.imageData = image
        }
        if let note {
            account.note = note
        }
    }

    public func delete___VARIABLE_modelName___(_ account: ___VARIABLE_modelName___) {
        context.delete(account)
        do {
            try context.save()

        } catch {
            logError("Error deleting account:", error: error)
        }
    }
}
EOF

echo "SwiftData files generated successfully!"
echo "Created:"
echo "- Injection/Injection.swift"
echo "- Models/___VARIABLE_modelName___.swift"
echo "- Services/AccountStorageService.swift"
