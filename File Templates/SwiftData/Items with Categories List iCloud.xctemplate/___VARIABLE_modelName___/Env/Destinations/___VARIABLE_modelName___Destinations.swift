// ___FILEHEADER___

import Foundation
import Models
import OversizeArchitecture

public nonisolated enum ___VARIABLE_modelName___Destinations: Hashable, Sendable {
    case ___VARIABLE_modelVariableName___List
    case ___VARIABLE_modelVariableName___Detail(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        onEdit: Callback<___VARIABLE_modelName___>? = nil,
        onDelete: Callback<___VARIABLE_modelName___>? = nil
    )
    case ___VARIABLE_modelVariableName___DetailId(
        id: UUID,
        onEdit: Callback<___VARIABLE_modelName___>? = nil,
        onDelete: Callback<___VARIABLE_modelName___>? = nil
    )
    case ___VARIABLE_modelVariableName___Create(onSave: Callback<___VARIABLE_modelName___>? = nil)
    case ___VARIABLE_modelVariableName___Edit(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        onSave: Callback<___VARIABLE_modelName___>? = nil
    )
    case ___VARIABLE_modelVariableName___EditId(
        id: UUID,
        onSave: Callback<___VARIABLE_modelName___>? = nil
    )
    case ___VARIABLE_categoryVariableName___List
    case ___VARIABLE_categoryVariableName___Detail(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        onEdit: Callback<___VARIABLE_categoryName___>? = nil,
        onDelete: Callback<___VARIABLE_categoryName___>? = nil
    )
    case ___VARIABLE_categoryVariableName___DetailId(
        id: UUID,
        onEdit: Callback<___VARIABLE_categoryName___>? = nil,
        onDelete: Callback<___VARIABLE_categoryName___>? = nil
    )
    case ___VARIABLE_categoryVariableName___Create(onSave: Callback<___VARIABLE_categoryName___>? = nil)
    case ___VARIABLE_categoryVariableName___Edit(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        onSave: Callback<___VARIABLE_categoryName___>? = nil
    )
    case ___VARIABLE_categoryVariableName___EditId(
        id: UUID,
        onSave: Callback<___VARIABLE_categoryName___>? = nil
    )
}
