// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_modelName___Entity {
    @Attribute(.unique)
    public private(set) var id: UUID

    @Attribute(.externalStorage)
    public var imageData: Data?

    // MARK: Basic Properties

    public var name: String
    public var colorData: ColorData
    public var date: Date
    public var note: String?
    public var isFavorite: Bool
    public var isArchive: Bool
    public var viewCount: Int

    public var ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity?

    // MARK: Initializers

    public init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        date: Date,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false,
        viewCount: Int = 0,
        ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity? = nil
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
        self.viewCount = viewCount
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        imageData = image
    }

    public convenience init(from domain: ___VARIABLE_modelName___, ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity? = nil) {
        self.init(
            id: domain.id,
            name: domain.name,
            color: domain.color,
            date: domain.date,
            image: domain.imageData,
            note: domain.note,
            isFavorite: domain.isFavorite,
            isArchive: domain.isArchive,
            viewCount: domain.viewCount,
            ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___
        )
    }
}

// MARK: - Computed Properties

public extension ___VARIABLE_modelName___Entity {
    var color: Color {
        colorData.color
    }

    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }
}

// MARK: - Query Extensions

public extension ___VARIABLE_modelName___Entity {
    static var all: [SortDescriptor<___VARIABLE_modelName___Entity>] {
        [SortDescriptor(\___VARIABLE_modelName___Entity.date, order: .reverse)]
    }
}
