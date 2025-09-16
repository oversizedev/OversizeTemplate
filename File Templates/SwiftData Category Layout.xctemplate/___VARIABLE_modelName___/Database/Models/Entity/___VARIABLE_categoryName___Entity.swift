// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_categoryName___Entity {
    @Attribute(.unique)
    public private(set) var id: UUID

    @Attribute(.externalStorage)
    public var imageData: Data?

    // MARK: Basic Properties

    public var name: String
    public var emoji: String?
    public var colorData: ColorData
    public var date: Date
    public var note: String?
    public var isFavorite: Bool
    public var viewCount: Int
    public var index: Int

    @Relationship(deleteRule: .nullify, inverse: \___VARIABLE_modelName___Entity.___VARIABLE_categoryVariableName___)
    public var ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___Entity] = []

    // MARK: Initializers

    public init(
        id: UUID = UUID(),
        name: String,
        emoji: String? = nil,
        color: Color,
        date: Date,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        viewCount: Int = 0,
        index: Int = 0,
        ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___Entity] = []
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.viewCount = viewCount
        self.index = index
        self.___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___
        imageData = image
    }

    public convenience init(from domain: ___VARIABLE_categoryName___, ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___Entity] = []) {
        self.init(
            id: domain.id,
            name: domain.name,
            emoji: domain.emoji,
            color: domain.color,
            date: domain.date,
            image: domain.imageData,
            note: domain.note,
            isFavorite: domain.isFavorite,
            viewCount: domain.viewCount,
            index: domain.index,
            ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___
        )
    }
}

// MARK: - Computed Properties

public extension ___VARIABLE_categoryName___Entity {
    var color: Color {
        colorData.color
    }

    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }
    
    var ___VARIABLE_modelVariableName___Count: Int {
        ___VARIABLE_modelPluralVariableName___.count
    }
}

// MARK: - Query Extensions

public extension ___VARIABLE_categoryName___Entity {
    static var all: [SortDescriptor<___VARIABLE_categoryName___Entity>] {
        [SortDescriptor(\___VARIABLE_categoryName___Entity.date, order: .reverse)]
    }
}
