// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeCore
import OversizeUI
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___EditViewState {
    public var name: String = ""
    public var emoji: String = ""
    public var selectedColor: Color = Self.availableColors.first ?? .blue
    public var note: String = ""
    public var isFavorite: Bool = false
    public var index: Int = 0
    public var hud: HUDState = .none
    public var alert: AlertState = .none
    public var destination: ___VARIABLE_modelName___Destinations?
    public let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?

    public init() {
        self.___VARIABLE_categoryVariableName___ = nil
    }

    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.name = ___VARIABLE_categoryVariableName___.name
        self.emoji = ___VARIABLE_categoryVariableName___.emoji ?? ""
        self.selectedColor = ___VARIABLE_categoryVariableName___.color
        self.note = ___VARIABLE_categoryVariableName___.note ?? ""
        self.isFavorite = ___VARIABLE_categoryVariableName___.isFavorite
        self.index = ___VARIABLE_categoryVariableName___.index
    }

    public var isEditMode: Bool {
        ___VARIABLE_categoryVariableName___ != nil
    }

    public var isValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    public static let availableColors: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal,
        .cyan, .blue, .indigo, .purple, .pink, .brown,
        .gray, .black
    ]
}