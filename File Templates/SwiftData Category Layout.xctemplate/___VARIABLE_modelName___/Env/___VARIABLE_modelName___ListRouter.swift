// ___FILEHEADER___

import Database
import Env
import NavigatorUI
import OversizeNavigation
import SwiftUI

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___List.build()
        case let .___VARIABLE_modelVariableName___Details(id):
            ___VARIABLE_modelName___Detail.build(input: ___VARIABLE_modelName___DetailInput(id: id))
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___Detail.build(input: ___VARIABLE_modelName___DetailInput(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
        case let .___VARIABLE_modelVariableName___Create(onSave: onSave):
            ___VARIABLE_modelName___Edit.build(input: ___VARIABLE_modelName___EditInput(), output: ___VARIABLE_modelName___EditOutput(onSave: onSave))
        case let .___VARIABLE_modelVariableName___EditId(id: id, onSave: onSave):
            ___VARIABLE_modelName___Edit.build(input: ___VARIABLE_modelName___EditInput(id: id), output: ___VARIABLE_modelName___EditOutput(onSave: onSave))
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, onSave: onSave):
            ___VARIABLE_modelName___Edit.build(input: ___VARIABLE_modelName___EditInput(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___), output: ___VARIABLE_modelName___EditOutput(onSave: onSave))
        case .___VARIABLE_modelVariableName___CategoriesList:
            ___VARIABLE_categoryName___List.build()
        case let .___VARIABLE_modelVariableName___CategoryDetails(id):
            ___VARIABLE_categoryName___Detail.build(input: ___VARIABLE_categoryName___DetailInput(id: id))
        case let .___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(___VARIABLE_modelVariableName___Category: ___VARIABLE_modelVariableName___Category):
            ___VARIABLE_categoryName___Detail.build(input: ___VARIABLE_categoryName___DetailInput(___VARIABLE_categoryVariableName___: ___VARIABLE_modelVariableName___Category))
        case let .___VARIABLE_modelVariableName___CategoryCreate(onSave: onSave):
            ___VARIABLE_categoryName___Edit.build(input: ___VARIABLE_categoryName___EditInput(), output: ___VARIABLE_categoryName___EditOutput(onSave: onSave))
        case let .___VARIABLE_modelVariableName___CategoryEditId(id: id, onSave: onSave):
            ___VARIABLE_categoryName___Edit.build(input: ___VARIABLE_categoryName___EditInput(id: id), output: ___VARIABLE_categoryName___EditOutput(onSave: onSave))
        case let .___VARIABLE_modelVariableName___CategoryEdit(___VARIABLE_modelVariableName___Category, onSave: onSave):
            ___VARIABLE_categoryName___Edit.build(input: ___VARIABLE_categoryName___EditInput(___VARIABLE_categoryVariableName___: ___VARIABLE_modelVariableName___Category), output: ___VARIABLE_categoryName___EditOutput(onSave: onSave))
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_modelVariableName___Create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___EditId, .___VARIABLE_modelVariableName___CategoryCreate, .___VARIABLE_modelVariableName___CategoryEdit, .___VARIABLE_modelVariableName___CategoryEditId:
            .managedSheet
        default:
            .push
        }
    }
}

