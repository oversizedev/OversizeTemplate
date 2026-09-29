// ___FILEHEADER___

import Env
import Models
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___EditViewState: ViewStateProtocol {
    // MARK: - Form

    public var form: Form
    public var originalForm: Form?

    // MARK: - User Interface

    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var isSaving: Bool = false
    public var isValidForm: Bool = false
    public var hasChanges: Bool = false
    public var isShow___VARIABLE_categoryName___Picker: Bool? = false

    // MARK: - Routing

    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // MARK: - Constants

    public let source: ___VARIABLE_modelName___EditInput.Source?
    public let ___VARIABLE_modelVariableName___Id: UUID

    // MARK: - View

    var title: String {
        source == nil ? "Create" : "Edit"
    }

    var ___VARIABLE_categoryVariableName___Options: [___VARIABLE_categoryName___?] {
        [nil] + (___VARIABLE_categoryPluralVariableName___State.result ?? [])
    }

    var selected___VARIABLE_categoryName___: ___VARIABLE_categoryName___? {
        form.___VARIABLE_categoryVariableName___Id.flatMap { categoryId in
            ___VARIABLE_categoryPluralVariableName___State.result?.first { $0.id == categoryId }
        }
    }

    // MARK: - Initialization

    public init(input: ___VARIABLE_modelName___Edit.Input?) {
        source = input?.source

        switch input?.source {
        case let .___VARIABLE_modelVariableName___(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            form = ___VARIABLE_modelName___EditViewModel.form(from: ___VARIABLE_modelVariableName___)
            originalForm = form
        case let .id(id):
            ___VARIABLE_modelVariableName___Id = id
            form = Form()
        case .none:
            ___VARIABLE_modelVariableName___Id = UUID()
            form = Form()
            form.date = Date()
            originalForm = form
        }
    }
}

// MARK: - Supporting types

public extension ___VARIABLE_modelName___EditViewState {
    struct Form: Equatable, Sendable {
        public var name: String = ""
        public var note: String = ""
        public var color: Color = .blue
        public var date: Date?
        public var image: PlatformImage?
        public var ___VARIABLE_categoryVariableName___Id: UUID?

        public init() {}

        public var trimmedName: String {
            name.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    enum FocusField: Hashable, Sendable {
        case name, note
    }
}
