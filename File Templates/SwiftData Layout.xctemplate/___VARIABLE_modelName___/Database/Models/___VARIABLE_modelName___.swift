// ___FILEHEADER___

import OversizeCore
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_modelName___: Identifiable, Equatable, @unchecked Sendable {
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

    // MARK: Initializer

    public init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        date: Date,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false,
        viewCount: Int = 0
    ) {
        self.id = id
        self.name = name
        colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
        self.viewCount = viewCount
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
