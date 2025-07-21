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
public final class ___VARIABLE_modelName___EditViewState: Sendable {
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
    public var ___VARIABLE_modelVariableName___State: LoadingViewState<___VARIABLE_modelName___> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = false

    /// Constants
    public let mode: EditMode
    public let ___VARIABLE_modelVariableName___Id: UUID

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
            "Create ___VARIABLE_modelName___"
        case .edit, .editId:
            "Edit ___VARIABLE_modelName___"
        }
    }

    /// Initialization
    public init(_ mode: EditMode) {
        self.mode = mode
        switch mode {
        case let .edit(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .editId(id):
            ___VARIABLE_modelVariableName___Id = id
        case .create:
            ___VARIABLE_modelVariableName___Id = UUID()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewState {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_modelName___EditViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }

    func setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        name = ___VARIABLE_modelVariableName___.name
        note = ___VARIABLE_modelVariableName___.note ?? ""
        color = ___VARIABLE_modelVariableName___.color
        url = nil // URL is not part of ___VARIABLE_modelName___ model
        date = ___VARIABLE_modelVariableName___.date
        calories = ___VARIABLE_modelVariableName___.calories
        protein = ___VARIABLE_modelVariableName___.protein
        carbs = ___VARIABLE_modelVariableName___.carbs
        fat = ___VARIABLE_modelVariableName___.fat
        fiber = ___VARIABLE_modelVariableName___.fiber
        sugar = ___VARIABLE_modelVariableName___.sugar
        sodium = ___VARIABLE_modelVariableName___.sodium
        servingSize = ___VARIABLE_modelVariableName___.servingSize
        category = ___VARIABLE_modelVariableName___.category
        brand = ___VARIABLE_modelVariableName___.brand
        barcode = ___VARIABLE_modelVariableName___.barcode
        
        #if os(macOS)
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = NSImage(data: imageData)
        }
        #else
        if let imageData = ___VARIABLE_modelVariableName___.imageData {
            image = UIImage(data: imageData)
        }
        #endif
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewState {
    enum EditMode {
        case create, edit(___VARIABLE_modelName___), editId(UUID)
    }

    /// FocusFields
    enum FocusField: Hashable, Sendable {
        case name, note, url, category, servingSize, brand, calories, protein, carbs, fat, fiber, sugar, sodium
    }
}
