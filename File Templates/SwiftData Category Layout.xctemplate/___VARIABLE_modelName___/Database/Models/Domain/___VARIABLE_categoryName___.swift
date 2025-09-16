// ___FILEHEADER___

import Foundation
import SwiftUI

public struct ___VARIABLE_categoryName___: Identifiable, Hashable, Equatable, Sendable {
    public let id: UUID
    public let imageData: Data?
    public let name: String
    public let emoji: String?
    public let color: Color
    public let date: Date
    public let note: String?
    public let isFavorite: Bool
    public let viewCount: Int
    public let index: Int

    public init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        name: String,
        emoji: String?,
        color: Color,
        date: Date,
        note: String? = nil,
        isFavorite: Bool = false,
        viewCount: Int = 0,
        index: Int = 0
    ) {
        self.id = id
        self.imageData = imageData
        self.name = name
        self.emoji = emoji
        self.color = color
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.viewCount = viewCount
        self.index = index
    }
}

// MARK: - Hashable

public extension ___VARIABLE_categoryName___ {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SwiftData Conversion

public extension ___VARIABLE_categoryName___ {
    init(from entity: ___VARIABLE_categoryName___Entity) {
        self.init(
            id: entity.id,
            imageData: entity.imageData,
            name: entity.name,
            emoji: entity.emoji,
            color: entity.color,
            date: entity.date,
            note: entity.note,
            isFavorite: entity.isFavorite,
            viewCount: entity.viewCount,
            index: entity.index
        )
    }
}

// MARK: - Computed Properties

public extension ___VARIABLE_categoryName___ {
    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }
    
    /// This would typically be computed from a relationship count
    /// For now, returning a placeholder value - should be replaced with actual relationship counting
    var ___VARIABLE_modelVariableName___Count: Int {
        // This is a placeholder - in real implementation this would count related items
        // Example: items.filter { $0.categoryId == self.id }.count
        0
    }
}

// MARK: - Query Extensions

public extension ___VARIABLE_categoryName___ {
    static var all: [SortDescriptor<___VARIABLE_categoryName___Entity>] {
        [SortDescriptor(\___VARIABLE_categoryName___Entity.date, order: .reverse)]
    }
}
