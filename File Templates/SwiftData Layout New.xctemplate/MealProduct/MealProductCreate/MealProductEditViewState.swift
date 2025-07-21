// ___FILEHEADER___

import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftUI

@MainActor
@Observable
public final class MealProductEditViewState: Sendable {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var url: URL?
    public var date: Date?
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif
    
    // Food-specific properties
    public var calories: Double = 0
    public var protein: Double = 0
    public var carbs: Double = 0
    public var fat: Double = 0
    public var fiber: Double?
    public var sugar: Double?
    public var sodium: Double?
    public var servingSize: String = "100g"
    public var category: String = "General"
    public var brand: String?
    public var barcode: String?

    /// User Interface
    public var mealProductState: LoadingViewState<MealProduct> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = false

    /// Constants
    public let mode: EditMode
    public let mealProductId: UUID

    /// Checks
    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil && calories == 0 && category == "General"
    }

    var isValidForm: Bool {
        !name.isEmpty && !category.isEmpty && !servingSize.isEmpty
    }

    /// View
    var title: String {
        switch mode {
        case .create:
            "Create Meal Product"
        case .edit, .editId:
            "Edit Meal Product"
        }
    }

    /// Initialization
    public init(_ mode: EditMode) {
        self.mode = mode
        switch mode {
        case let .edit(mealProduct):
            mealProductId = mealProduct.id
            mealProductState = .result(mealProduct)
            setFields(mealProduct: mealProduct)
        case let .editId(id):
            mealProductId = id
        case .create:
            mealProductId = UUID()
        }
    }
}

// MARK: - User Actions

public extension MealProductEditViewState {
    func update(_ handler: @Sendable @MainActor (MealProductEditViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }

    func setFields(mealProduct: MealProduct) {
        name = mealProduct.name
        note = mealProduct.note ?? ""
        color = mealProduct.color
        url = nil // URL is not part of MealProduct model
        date = mealProduct.date
        calories = mealProduct.calories
        protein = mealProduct.protein
        carbs = mealProduct.carbs
        fat = mealProduct.fat
        fiber = mealProduct.fiber
        sugar = mealProduct.sugar
        sodium = mealProduct.sodium
        servingSize = mealProduct.servingSize
        category = mealProduct.category
        brand = mealProduct.brand
        barcode = mealProduct.barcode
        
        #if os(macOS)
        if let imageData = mealProduct.imageData {
            image = NSImage(data: imageData)
        }
        #else
        if let imageData = mealProduct.imageData {
            image = UIImage(data: imageData)
        }
        #endif
    }
}

// MARK: - EditMode types

public extension MealProductEditViewState {
    enum EditMode {
        case create, edit(MealProduct), editId(UUID)
    }

    /// FocusFields
    enum FocusField: Hashable, Sendable {
        case name, note, url, category, servingSize, brand, calories, protein, carbs, fat, fiber, sugar, sodium
    }
}
