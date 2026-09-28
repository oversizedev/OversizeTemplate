// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Observation
import OversizeArchitecture
import OversizeCore
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
    public var selected___VARIABLE_categoryName___Id: UUID?

    /// User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var hud: OversizeNavigation.HUD?
    public var alert: AppAlert?
    public var destination: ___VARIABLE_modelName___Destinations?
    public var isShow___VARIABLE_categoryName___Picker: Bool? = false

    /// Constants
    public let source: ___VARIABLE_modelName___EditInput.Source?
    public let ___VARIABLE_modelVariableName___Id: UUID

    // Original Values
    #if os(macOS)
        public var originalImage: NSImage?
    #else
        public var originalImage: UIImage?
    #endif

    /// View
    var title: String {
        if source == nil {
            "Create"
        } else {
            "Edit"
        }
    }

    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isImageChanged: Bool {
        image !== originalImage
    }

    var selected___VARIABLE_categoryName___: ___VARIABLE_categoryName___? {
        selected___VARIABLE_categoryName___Id.flatMap { categoryId in
            ___VARIABLE_categoryPluralVariableName___State.result?.first { $0.id == categoryId }
        }
    }

    /// Initialization
    public init(input: ___VARIABLE_modelName___Edit.Input?) {
        source = input?.source

        switch input?.source {
        case let .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            name = ___VARIABLE_modelVariableName___.name
            note = ___VARIABLE_modelVariableName___.note ?? ""
            color = ___VARIABLE_modelVariableName___.color
            date = ___VARIABLE_modelVariableName___.date
            #if os(macOS)
                image = ___VARIABLE_modelVariableName___.imageData.flatMap { NSImage(data: $0) }
            #else
                image = ___VARIABLE_modelVariableName___.imageData.flatMap { UIImage(data: $0) }
            #endif
            originalImage = image
            selected___VARIABLE_categoryName___Id = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id
        case let .id(id):
            ___VARIABLE_modelVariableName___Id = id
        case .none:
            ___VARIABLE_modelVariableName___Id = UUID()
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
