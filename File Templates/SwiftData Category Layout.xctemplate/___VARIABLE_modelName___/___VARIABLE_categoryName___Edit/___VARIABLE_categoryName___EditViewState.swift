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
public final class ___VARIABLE_categoryName___EditViewState: ViewStateProtocol {
    /// Forms
    public var name: String = .init()
    public var emoji: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var imageData: Data?
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
    public var hud: OversizeNavigation.HUD?

    /// Constants
    public let ___VARIABLE_categoryVariableName___Id: UUID?

    /// View
    var title: String {
        if isEdit {
            "Edit \(___VARIABLE_categoryVariableName___State.successResult?.name ?? "")"
        } else {
            "Create ___VARIABLE_categoryVariableName___"
        }
    }

    var isEdit: Bool {
        ___VARIABLE_categoryVariableName___Id != nil
    }

    /// Initialization
    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___? = nil) {
        if let ___VARIABLE_categoryVariableName___ {
            self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
            self.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
            setFields(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        } else {
            self.___VARIABLE_categoryVariableName___Id = nil
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___EditViewState {
    func setFields(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        name = ___VARIABLE_categoryVariableName___.name
        emoji = ___VARIABLE_categoryVariableName___.emoji ?? ""
        note = ___VARIABLE_categoryVariableName___.note ?? ""
        color = ___VARIABLE_categoryVariableName___.color
        imageData = ___VARIABLE_categoryVariableName___.imageData
        isEmptyForm = false
        checkFormValidation()
    }

    func checkFormValidation() {
        isValidForm = !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        isEmptyForm = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                     emoji.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                     note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
                     imageData == nil
    }
}

// MARK: - Focus Field

public extension ___VARIABLE_categoryName___EditViewState {
    enum FocusField: Int, CaseIterable {
        case name
        case emoji
        case note
    }
}