// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___EditViewState: ViewStateProtocol {
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
    public var selectedCategory: ___VARIABLE_categoryName___?

    /// User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var categoriesState: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var hud: OversizeNavigation.HUD?
    public var destination: ___VARIABLE_modelName___Destinations?
    public var isShowCategoryPicker: Bool? = false

    /// Constants
    public let source: ___VARIABLE_modelName___EditInput.Source?
    public let ___VARIABLE_modelVariableName___Id: UUID

    /// View
    var title: String {
        if source == nil {
            "Create product"
        } else {
            "Edit \(___VARIABLE_modelVariableName___State.successResult?.name ?? "")"
        }
    }

    /// Initialization
    public init(input: ___VARIABLE_modelName___Edit.Input?) {
        source = input?.source

        switch input?.source {
        case let .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .id(id):
            ___VARIABLE_modelVariableName___Id = id
        case .none:
            ___VARIABLE_modelVariableName___Id = UUID()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewState {
    func setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        name = ___VARIABLE_modelVariableName___.name
        note = ___VARIABLE_modelVariableName___.note ?? ""
        color = ___VARIABLE_modelVariableName___.color
        date = ___VARIABLE_modelVariableName___.date
        if let data = ___VARIABLE_modelVariableName___.imageData {
            #if os(macOS)
            image = NSImage(data: data)
            #else
            image = UIImage(data: data)
            #endif
        }
        if let categoryId = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id {
            selectedCategory = categoriesState.successResult?.first { $0.id == categoryId }
        } else {
            selectedCategory = nil
        }
    }

    func setCategories(_ categories: [___VARIABLE_categoryName___]) {
        if let currentCategoryId = selectedCategory?.id {
            selectedCategory = categories.first { $0.id == currentCategoryId }
        }
    }
}

// MARK: - Supporting types

public extension ___VARIABLE_modelName___EditViewState {
    /// FocusFields
    enum FocusField: String, Hashable, Sendable {
        case name, note, url
    }
}