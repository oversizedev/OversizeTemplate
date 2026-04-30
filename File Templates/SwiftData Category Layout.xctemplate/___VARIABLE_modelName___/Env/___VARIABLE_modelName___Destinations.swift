// ___FILEHEADER___

import Database
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
    case ___VARIABLE_modelVariableName___CategoriesList
    case ___VARIABLE_modelVariableName___CategoryDetails(id: UUID)
    case ___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(___VARIABLE_modelVariableName___Category: ___VARIABLE_categoryName___)
    case ___VARIABLE_modelVariableName___CategoryCreate(onSave: Callback<___VARIABLE_categoryName___>? = nil)
    case ___VARIABLE_modelVariableName___CategoryEditId(id: UUID, onSave: Callback<___VARIABLE_categoryName___>? = nil)
    case ___VARIABLE_modelVariableName___CategoryEdit(_ ___VARIABLE_modelVariableName___Category: ___VARIABLE_categoryName___, onSave: Callback<___VARIABLE_categoryName___>? = nil)
}