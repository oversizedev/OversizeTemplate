// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_categoryName___EditViewState: ViewStateProtocol {
    public enum CallbackAction: Sendable {
        case save
    }

    // User Interface
    public var name: String = ""
    public var description: String = ""
    public var color: Color = .blue
    public var isFavorite: Bool = false
    public var isArchive: Bool = false

    // Routing
    public var destination: ___VARIABLE_categoryName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Static
    public let ___VARIABLE_categoryVariableName___Id: UUID?
    public let callback: Callback<CallbackAction>?

    // Initialization
    public init(callback: Callback<CallbackAction>?) {
        ___VARIABLE_categoryVariableName___Id = nil
        self.callback = callback
    }

    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, callback: Callback<CallbackAction>?) {
        ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
        name = ___VARIABLE_categoryVariableName___.name
        description = ___VARIABLE_categoryVariableName___.description
        color = ___VARIABLE_categoryVariableName___.color
        isFavorite = ___VARIABLE_categoryVariableName___.isFavorite
        isArchive = ___VARIABLE_categoryVariableName___.isArchive
        self.callback = callback
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___EditViewState {
    var isEdit: Bool {
        ___VARIABLE_categoryVariableName___Id != nil
    }

    var title: String {
        isEdit ? "Edit ___VARIABLE_categoryName___" : "New ___VARIABLE_categoryName___"
    }

    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}