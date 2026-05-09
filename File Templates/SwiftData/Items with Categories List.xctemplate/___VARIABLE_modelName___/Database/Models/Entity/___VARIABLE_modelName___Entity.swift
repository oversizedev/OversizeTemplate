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
        ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity? = nil
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
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
