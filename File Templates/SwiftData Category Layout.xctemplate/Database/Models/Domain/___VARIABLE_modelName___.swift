// ___FILEHEADER___

import Foundation
import SwiftUI

public struct ___VARIABLE_modelName___: Identifiable, Hashable, Equatable, Sendable {
    public let id: UUID
    public let imageData: Data?
    public let image: Image?
    public let name: String
    public let color: Color
    public let date: Date
    public let note: String?
    public let isFavorite: Bool
    public let isArchive: Bool
    public let viewCount: Int
    public let ___VARIABLE_categoryVariableName___Id: UUID?

    public init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        name: String,
        color: Color,
        date: Date,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false,
        viewCount: Int = 0,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) {
        self.id = id
        self.imageData = imageData
        self.name = name
        self.color = color
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
        self.viewCount = viewCount
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id
        if let imageData {
            image = .init(data: imageData)
        } else {
            image = nil
        }
    }
}

// MARK: - Hashable

public extension ___VARIABLE_modelName___ {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SwiftData Conversion

public extension ___VARIABLE_modelName___ {
    init(from entity: ___VARIABLE_modelName___Entity) {
        self.init(
            id: entity.id,
            imageData: entity.imageData,
            name: entity.name,
            color: entity.color,
            date: entity.date,
            note: entity.note,
            isFavorite: entity.isFavorite,
            isArchive: entity.isArchive,
            viewCount: entity.viewCount,
            ___VARIABLE_categoryVariableName___Id: entity.___VARIABLE_categoryVariableName___?.id
        )
    }
}

// MARK: - Computed Properties

public extension ___VARIABLE_modelName___ {
    /// Helper function to get category name from categoryId - should be used with lazy loading
    func ___VARIABLE_categoryVariableName___Name(from ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> String? {
        guard let ___VARIABLE_categoryVariableName___Id else { return nil }
        return ___VARIABLE_categoryPluralVariableName___.first { $0.id == ___VARIABLE_categoryVariableName___Id }?.name
    }

    /// Helper function to get category from categoryId - should be used with lazy loading
    func ___VARIABLE_categoryVariableName___(from ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> ___VARIABLE_categoryName___? {
        guard let ___VARIABLE_categoryVariableName___Id else { return nil }
        return ___VARIABLE_categoryPluralVariableName___.first { $0.id == ___VARIABLE_categoryVariableName___Id }
    }
}
