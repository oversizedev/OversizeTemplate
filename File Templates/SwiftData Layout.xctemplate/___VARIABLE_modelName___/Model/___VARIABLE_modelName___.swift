 // ___FILEHEADER___

import OversizeCore
import OversizeModels
import SwiftData
import SwiftUI

@Model
public final class ___VARIABLE_modelName___: Identifiable, Equatable {
    
    @Attribute(.unique)
    public var id: UUID

    public var name: String

    public var url: URL?

    public var colorData: ColorData
    
    @Attribute(.externalStorage)
    public var imageData: Data?

    public var date: Date?

    public var note: String?

    public var isFavorite: Bool

    public var isArchive: Bool

    public var views: Int

    public init(
        id: UUID,
        name: String,
        url: URL? = nil,
        color: Color,
        date: Date? = nil,
        image: Data? = nil,
        note: String? = nil,
        isFavorite: Bool = false,
        isArchive: Bool = false,
        views: Int = 0
    ) {
        self.id = id
        self.name = name
        self.url = url
        self.colorData = .init(color: color)
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.isArchive = isArchive
        self.views = views
        self.imageData = image
    }
}

public extension ___VARIABLE_modelName___ {
    static var all: FetchDescriptor<___VARIABLE_modelName___> {
        FetchDescriptor(sortBy: [SortDescriptor(\___VARIABLE_modelName___.name, order: .reverse)])
    }
    
    var color: Color {
        colorData.color
    }
    
    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }
}
