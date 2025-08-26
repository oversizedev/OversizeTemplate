// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_categoryName___: Identifiable, Equatable, @unchecked Sendable {
    @Attribute(.unique)
    public private(set) var id: UUID

    @Attribute(.externalStorage)
    public var imageData: Data?

    // MARK: Basic Properties

    public var name: String
    public var colorData: ColorData
    public var note: String?
    public var sortOrder: Int

    // MARK: Relationships

    @Relationship(deleteRule: .cascade, inverse: \___VARIABLE_modelName___.___VARIABLE_categoryVariableName___)
    public var ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___] = []

    // MARK: Initializer

    public init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        image: Data? = nil,
        note: String? = nil,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.note = note
        self.sortOrder = sortOrder
        imageData = image
    }
}

public extension ___VARIABLE_categoryName___ {
    static var all: FetchDescriptor<___VARIABLE_categoryName___> {
        FetchDescriptor(
            sortBy: [SortDescriptor(
                \___VARIABLE_categoryName___.sortOrder,
                order: .forward
            ), SortDescriptor(
                \___VARIABLE_categoryName___.name,
                order: .forward
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

    var ___VARIABLE_modelVariableName___Count: Int {
        ___VARIABLE_modelPluralVariableName___.count
    }
}