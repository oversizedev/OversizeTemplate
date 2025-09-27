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

extension ___VARIABLE_modelName___Destinations: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            hasher.combine("___VARIABLE_modelPluralVariableName___List")
        case let .___VARIABLE_modelVariableName___Details(id):
            hasher.combine("___VARIABLE_modelVariableName___Details")
            hasher.combine(id)
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            hasher.combine("___VARIABLE_modelVariableName___Details___VARIABLE_modelName___")
            hasher.combine(___VARIABLE_modelVariableName___.id)
        case .___VARIABLE_modelVariableName___Create:
            hasher.combine("___VARIABLE_modelVariableName___Create")
        case let .___VARIABLE_modelVariableName___EditId(id, onSave: _):
            hasher.combine("___VARIABLE_modelVariableName___EditId")
            hasher.combine(id)
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, onSave: _):
            hasher.combine("___VARIABLE_modelVariableName___Edit")
            hasher.combine(___VARIABLE_modelVariableName___.id)
        case .___VARIABLE_modelVariableName___CategoriesList:
            hasher.combine("___VARIABLE_modelVariableName___CategoriesList")
        case let .___VARIABLE_modelVariableName___CategoryDetails(id):
            hasher.combine("___VARIABLE_modelVariableName___CategoryDetails")
            hasher.combine(id)
        case let .___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(___VARIABLE_modelVariableName___Category):
            hasher.combine("___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___")
            hasher.combine(___VARIABLE_modelVariableName___Category.id)
        case .___VARIABLE_modelVariableName___CategoryCreate:
            hasher.combine("___VARIABLE_modelVariableName___CategoryCreate")
        case let .___VARIABLE_modelVariableName___CategoryEditId(id, onSave: _):
            hasher.combine("___VARIABLE_modelVariableName___CategoryEditId")
            hasher.combine(id)
        case let .___VARIABLE_modelVariableName___CategoryEdit(___VARIABLE_modelVariableName___Category, onSave: _):
            hasher.combine("___VARIABLE_modelVariableName___CategoryEdit")
            hasher.combine(___VARIABLE_modelVariableName___Category.id)
        }
    }

    public static func == (lhs: ___VARIABLE_modelName___Destinations, rhs: ___VARIABLE_modelName___Destinations) -> Bool {
        switch (lhs, rhs) {
        case (.___VARIABLE_modelPluralVariableName___List, .___VARIABLE_modelPluralVariableName___List):
            return true
        case let (.___VARIABLE_modelVariableName___Details(lhsId), .___VARIABLE_modelVariableName___Details(rhsId)):
            return lhsId == rhsId
        case let (.___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(lhs___VARIABLE_modelName___), .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(rhs___VARIABLE_modelName___)):
            return lhs___VARIABLE_modelName___.id == rhs___VARIABLE_modelName___.id
        case (.___VARIABLE_modelVariableName___Create, .___VARIABLE_modelVariableName___Create):
            return true
        case let (.___VARIABLE_modelVariableName___EditId(lhsId, onSave: _), .___VARIABLE_modelVariableName___EditId(rhsId, onSave: _)):
            return lhsId == rhsId
        case let (.___VARIABLE_modelVariableName___Edit(lhs___VARIABLE_modelName___, onSave: _), .___VARIABLE_modelVariableName___Edit(rhs___VARIABLE_modelName___, onSave: _)):
            return lhs___VARIABLE_modelName___.id == rhs___VARIABLE_modelName___.id
        case (.___VARIABLE_modelVariableName___CategoriesList, .___VARIABLE_modelVariableName___CategoriesList):
            return true
        case let (.___VARIABLE_modelVariableName___CategoryDetails(lhsId), .___VARIABLE_modelVariableName___CategoryDetails(rhsId)):
            return lhsId == rhsId
        case let (.___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(lhsCategory), .___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(rhsCategory)):
            return lhsCategory.id == rhsCategory.id
        case (.___VARIABLE_modelVariableName___CategoryCreate, .___VARIABLE_modelVariableName___CategoryCreate):
            return true
        case let (.___VARIABLE_modelVariableName___CategoryEditId(lhsId, onSave: _), .___VARIABLE_modelVariableName___CategoryEditId(rhsId, onSave: _)):
            return lhsId == rhsId
        case let (.___VARIABLE_modelVariableName___CategoryEdit(lhsCategory, onSave: _), .___VARIABLE_modelVariableName___CategoryEdit(rhsCategory, onSave: _)):
            return lhsCategory.id == rhsCategory.id
        default:
            return false
        }
    }
}