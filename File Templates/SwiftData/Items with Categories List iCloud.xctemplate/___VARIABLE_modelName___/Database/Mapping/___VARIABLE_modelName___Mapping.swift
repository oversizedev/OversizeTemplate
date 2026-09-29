// ___FILEHEADER___

import Foundation
import Models
import OversizeCore

public extension ___VARIABLE_modelName___ {
    init(from entity: ___VARIABLE_modelName___Entity) {
        self.init(
            id: entity.id,
            imageData: entity.imageData,
            name: entity.name,
            color: entity.color,
            date: entity.date,
            note: entity.note,
            isFavorite: entity.isFavorite,
            ___VARIABLE_categoryVariableName___Id: entity.___VARIABLE_categoryVariableName___?.id
        )
    }
}

public extension ___VARIABLE_modelName___Entity {
    convenience init(from domain: ___VARIABLE_modelName___, ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___Entity? = nil) {
        self.init(
            id: domain.id,
            name: domain.name,
            color: domain.color,
            date: domain.date,
            image: domain.imageData,
            note: domain.note,
            isFavorite: domain.isFavorite,
            ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___
        )
    }
}
