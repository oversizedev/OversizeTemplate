// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import NavigatorUI
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
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

    /// User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var hud: OversizeNavigation.HUD?

    /// Callback
    let handler: Callback<CallbackAction>

    /// Constants
    public let mode: EditMode
    public let ___VARIABLE_modelVariableName___Id: UUID

    /// View
    var title: String {
        switch mode {
        case .create:
            "Create ___VARIABLE_modelVariableName___"
        case .edit, .editId:
            "Edit \(___VARIABLE_modelVariableName___State.successResult?.name ?? "")"
        }
    }

    /// Initialization
    public init(_ mode: EditMode, handler: Callback<CallbackAction>) {
        self.mode = mode
        self.handler = handler
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
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewState {
    enum EditMode: Sendable {
        case create, edit(___VARIABLE_modelName___), editId(UUID)
    }

    /// FocusFields
    enum FocusField: String, Hashable, Sendable {
        case name, note, url
    }

    enum CallbackAction: Sendable {
        case save
    }
}
