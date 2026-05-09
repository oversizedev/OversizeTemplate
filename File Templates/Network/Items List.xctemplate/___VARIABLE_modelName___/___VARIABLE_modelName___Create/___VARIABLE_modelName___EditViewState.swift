// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___EditViewState: ViewStateProtocol, Sendable {
    public typealias Module = ___VARIABLE_modelName___Edit

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

    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = false

    public let mode: EditMode
    public let ___VARIABLE_modelVariableName___Id: String

    var isEmptyForm: Bool {
        name.isEmpty && note.isEmpty && url == nil
    }

    var isValidForm: Bool {
        !name.isEmpty
    }

    var title: String {
        switch mode {
        case .create:
            "Create ___VARIABLE_modelVariableName___"
        case .edit, .editId:
            "Edit ___VARIABLE_modelVariableName___"
        }
    }

    public required init(input: Module.Input?) {
        let mode = input?.mode ?? .create
        self.mode = mode
        switch mode {
        case let .edit(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id.uuidString
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .editId(id):
            ___VARIABLE_modelVariableName___Id = id
        case .create:
            ___VARIABLE_modelVariableName___Id = UUID().uuidString
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewState {
    func setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        // Uncomment and modify based on your model properties
        // name = ___VARIABLE_modelVariableName___.name ?? ""
        // note = ___VARIABLE_modelVariableName___.note ?? ""
        // color = Color(___VARIABLE_modelVariableName___.color ?? "blue")
        // url = ___VARIABLE_modelVariableName___.url
        // date = ___VARIABLE_modelVariableName___.date
    }
}

// MARK: - EditMode types

public extension ___VARIABLE_modelName___EditViewState {
    enum EditMode: Sendable {
        case create, edit(___VARIABLE_modelName___), editId(String)
    }

    enum FocusField: Hashable, Sendable {
        case name, note, url
    }
}
