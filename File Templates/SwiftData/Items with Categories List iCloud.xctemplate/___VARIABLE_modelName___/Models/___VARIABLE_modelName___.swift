// ___FILEHEADER___

import Foundation
import OversizeCore
import SwiftUI

public struct ___VARIABLE_modelName___: Identifiable, Hashable, Equatable, Sendable {
    public let id: UUID
    public let imageData: Data?
    public let name: String
    public let color: Color
    public let date: Date
    public let note: String?
    public let isFavorite: Bool
    public let ___VARIABLE_categoryVariableName___Id: UUID?

    public init(
        id: UUID = UUID(),
        imageData: Data? = nil,
        name: String,
        color: Color,
        date: Date,
        note: String? = nil,
        isFavorite: Bool = false,
        ___VARIABLE_categoryVariableName___Id: UUID? = nil
    ) {
        self.id = id
        self.imageData = imageData
        self.name = name
        self.color = color
        self.date = date
        self.note = note
        self.isFavorite = isFavorite
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id
    }
}

// MARK: - Hashable

public extension ___VARIABLE_modelName___ {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Computed Properties

public extension ___VARIABLE_modelName___ {
    var image: Image? {
        guard let imageData else { return nil }
        return .init(data: imageData)
    }

    func ___VARIABLE_categoryVariableName___Name(from ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> String? {
        guard let ___VARIABLE_categoryVariableName___Id else { return nil }
        return ___VARIABLE_categoryPluralVariableName___.first { $0.id == ___VARIABLE_categoryVariableName___Id }?.name
    }

    func ___VARIABLE_categoryVariableName___(from ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> ___VARIABLE_categoryName___? {
        guard let ___VARIABLE_categoryVariableName___Id else { return nil }
        return ___VARIABLE_categoryPluralVariableName___.first { $0.id == ___VARIABLE_categoryVariableName___Id }
    }
}
