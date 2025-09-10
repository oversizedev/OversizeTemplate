// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_categoryName___Destinations {
    case ___VARIABLE_categoryPluralVariableName___List
    case ___VARIABLE_categoryPluralVariableName___Archive
    case ___VARIABLE_categoryPluralVariableName___Favorites
    case ___VARIABLE_categoryVariableName___Details(id: UUID)
    case ___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___)
    case ___VARIABLE_categoryVariableName___Create(callback: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>)
    case ___VARIABLE_categoryVariableName___EditId(id: UUID, callback: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>)
    case ___VARIABLE_categoryVariableName___Edit(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, callback: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>)
}

extension ___VARIABLE_categoryName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_categoryPluralVariableName___List:
            ___VARIABLE_categoryName___ListScreen.build()
        case .___VARIABLE_categoryPluralVariableName___Archive:
            ___VARIABLE_categoryName___ListScreen.buildArchive()
        case .___VARIABLE_categoryPluralVariableName___Favorites:
            ___VARIABLE_categoryName___ListScreen.buildFavorites()
        case let .___VARIABLE_categoryVariableName___Details(id):
            ___VARIABLE_categoryName___DetailScreen.build(id: id)
        case let .___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryName___DetailScreen.build(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        case let .___VARIABLE_categoryVariableName___Create(callback):
            ___VARIABLE_categoryName___EditScreen.build(handler: callback)
        case let .___VARIABLE_categoryVariableName___EditId(id: id, callback: callback):
            ___VARIABLE_categoryName___EditScreen.buildEdit(id: id, handler: callback)
        case let .___VARIABLE_categoryVariableName___Edit(___VARIABLE_categoryVariableName___, callback: callback):
            ___VARIABLE_categoryName___EditScreen.buildEdit(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___, handler: callback)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_categoryVariableName___Create, .___VARIABLE_categoryVariableName___Edit, .___VARIABLE_categoryVariableName___EditId:
            .managedSheet
        default:
            .push
        }
    }
}