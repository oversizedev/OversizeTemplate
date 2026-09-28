// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___EditViewState: ViewStateProtocol {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var emoji: String = .init("🍏")
    public var color: Color = .blue
    public var url: URL?
    public var date: Date?
    #if os(macOS)
        public var image: NSImage?
    #else
        public var image: UIImage?
    #endif

    /// User Interface
    public var ___VARIABLE_categoryVariableName___State: LoadingState<___VARIABLE_categoryName___> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var isDuplicateName: Bool = false
    public var hud: OversizeNavigation.HUD?
    public var alert: AppAlert?

    public let emojis = "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑"

    /// Constants
    public let source: ___VARIABLE_categoryName___EditInput.Source?
    public let ___VARIABLE_categoryVariableName___Id: UUID

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

    /// Initialization
    public init(input: ___VARIABLE_categoryName___Edit.Input?) {
        source = input?.source

        switch input?.source {
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
            ___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
            name = ___VARIABLE_categoryVariableName___.name
            emoji = ___VARIABLE_categoryVariableName___.emoji ?? "🥕"
            note = ___VARIABLE_categoryVariableName___.note ?? ""
            color = ___VARIABLE_categoryVariableName___.color
            date = ___VARIABLE_categoryVariableName___.date
            #if os(macOS)
                image = ___VARIABLE_categoryVariableName___.imageData.flatMap { NSImage(data: $0) }
            #else
                image = ___VARIABLE_categoryVariableName___.imageData.flatMap { UIImage(data: $0) }
            #endif
            originalImage = image
        case let .id(id):
            ___VARIABLE_categoryVariableName___Id = id
        case .none:
            ___VARIABLE_categoryVariableName___Id = UUID()
        }
    }
}

// MARK: - Supporting types

public extension ___VARIABLE_categoryName___EditViewState {
    /// FocusFields
    enum FocusField: String, Hashable, Sendable {
        case name, note, url
    }
}
