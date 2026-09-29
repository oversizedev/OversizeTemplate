// ___FILEHEADER___

import Foundation
import Models
import OversizeCore

public extension ___VARIABLE_categoryName___ {
    init(from entity: ___VARIABLE_categoryName___Entity) {
        self.init(
            id: entity.id,
            imageData: entity.imageData,
            name: entity.name,
            emoji: entity.emoji,
            color: entity.color,
            date: entity.date,
            note: entity.note,
            isFavorite: entity.isFavorite,
            index: entity.index
        )
    }
}

public extension ___VARIABLE_categoryName___Entity {
    convenience init(from domain: ___VARIABLE_categoryName___, ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___Entity] = []) {
        self.init(
            id: domain.id,
            name: domain.name,
            emoji: domain.emoji,
            color: domain.color,
            date: domain.date,
            image: domain.imageData,
            note: domain.note,
            isFavorite: domain.isFavorite,
            index: domain.index,
            ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___
        )
    }
}
