// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import Foundation
import OversizeArchitecture

public enum ___VARIABLE_modelName___Destinations: Hashable {
    case ___VARIABLE_modelPluralVariableName___List
    case ___VARIABLE_modelVariableName___Details(id: UUID)
    case ___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___Create(onSave: Callback<___VARIABLE_modelName___>? = nil)
    case ___VARIABLE_modelVariableName___EditId(id: UUID, onSave: Callback<___VARIABLE_modelName___>? = nil)
    case ___VARIABLE_modelVariableName___Edit(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, onSave: Callback<___VARIABLE_modelName___>? = nil)
    case ___VARIABLE_categoryPluralVariableName___List
    case ___VARIABLE_categoryVariableName___Details(id: UUID)
    case ___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___)
    case ___VARIABLE_categoryVariableName___Create(onSave: Callback<___VARIABLE_categoryName___>? = nil)
    case ___VARIABLE_categoryVariableName___EditId(id: UUID, onSave: Callback<___VARIABLE_categoryName___>? = nil)
    case ___VARIABLE_categoryVariableName___Edit(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, onSave: Callback<___VARIABLE_categoryName___>? = nil)
}
