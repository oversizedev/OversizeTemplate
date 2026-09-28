// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___EditViewState: ViewStateProtocol {
    /// Form
    public var form: Form
    public var originalForm: Form?

    /// User Interface
    public var ___VARIABLE_categoryVariableName___State: LoadingState<___VARIABLE_categoryName___> = .idle
    public var isSaving: Bool = false
    public var isValidForm: Bool = false
    public var isDuplicateName: Bool = false
    public var hasChanges: Bool = false

    /// Routing
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    /// Constants
    public let source: ___VARIABLE_categoryName___EditInput.Source?
    public let ___VARIABLE_categoryVariableName___Id: UUID
    public let emojis = "🍏🍎🍐🍊🍋🍋‍🟩🍌🍉🍇🍓🫐🍈🍒🍑🥭🍍🥥🥝🍅🍆🥑"

    /// View
    var title: String {
        source == nil ? "Create" : "Edit"
    }

    /// Initialization
    public init(input: ___VARIABLE_categoryName___Edit.Input?) {
        source = input?.source

        switch input?.source {
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
            ___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
            form = ___VARIABLE_categoryName___EditViewModel.form(from: ___VARIABLE_categoryVariableName___)
            originalForm = form
        case let .id(id):
            ___VARIABLE_categoryVariableName___Id = id
            form = Form()
        case .none:
            ___VARIABLE_categoryVariableName___Id = UUID()
            form = Form()
            form.date = Date()
            originalForm = form
        }
    }
}

// MARK: - Supporting types

public extension ___VARIABLE_categoryName___EditViewState {
    struct Form: Equatable, Sendable {
        public var name: String = ""
        public var note: String = ""
        public var emoji: String = ___VARIABLE_categoryName___.defaultEmoji
        public var color: Color = .blue
        public var date: Date?
        public var image: PlatformImage?

        public init() {}

        public var trimmedName: String {
            name.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    enum FocusField: Hashable, Sendable {
        case name, note
    }
}
