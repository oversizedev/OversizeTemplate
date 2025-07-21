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
    
    // MARK: Food-specific Properties
    
    public var calories: Double
    public var protein: Double
    public var carbs: Double
    public var fat: Double
    public var fiber: Double?
    public var sugar: Double?
    public var sodium: Double?
    public var servingSize: String
    public var category: String
    public var brand: String?
    public var barcode: String?

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
        viewCount: Int = 0,
        calories: Double = 0,
        protein: Double = 0,
        carbs: Double = 0,
        fat: Double = 0,
        fiber: Double? = nil,
        sugar: Double? = nil,
        sodium: Double? = nil,
        servingSize: String = "100g",
        category: String = "General",
        brand: String? = nil,
        barcode: String? = nil
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
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.fiber = fiber
        self.sugar = sugar
        self.sodium = sodium
        self.servingSize = servingSize
        self.category = category
        self.brand = brand
        self.barcode = barcode
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
    
    var totalMacros: Double {
        protein + carbs + fat
    }
    
    var caloriesFromMacros: Double {
        (protein * 4) + (carbs * 4) + (fat * 9)
    }
}
