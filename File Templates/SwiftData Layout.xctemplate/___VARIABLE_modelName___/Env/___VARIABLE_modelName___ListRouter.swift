// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_modelName___Destinations {
    case ___VARIABLE_modelPluralVariableName___List
    case ___VARIABLE_modelPluralVariableName___Archive
    case ___VARIABLE_modelPluralVariableName___Favorites
    case ___VARIABLE_modelVariableName___Details(id: UUID)
    case ___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___Create(callback: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>)
    case ___VARIABLE_modelVariableName___EditId(id: UUID, callback: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>)
    case ___VARIABLE_modelVariableName___Edit(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, callback: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>)
}

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___ListScreen.build()
        case .___VARIABLE_modelPluralVariableName___Archive:
            ___VARIABLE_modelName___ListScreen.buildArchive()
        case .___VARIABLE_modelPluralVariableName___Favorites:
            ___VARIABLE_modelName___ListScreen.buildFavorites()
        case let .___VARIABLE_modelVariableName___Details(id):
            ___VARIABLE_modelName___DetailScreen.build(id: id)
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen.build(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .___VARIABLE_modelVariableName___Create(callback):
            ___VARIABLE_modelName___EditScreen.build(handler: callback)
        case let .___VARIABLE_modelVariableName___EditId(id: id, callback: callback):
            ___VARIABLE_modelName___EditScreen.buildEdit(id: id, handler: callback)
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, callback: callback):
            ___VARIABLE_modelName___EditScreen.buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___, handler: callback)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_modelVariableName___Create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___EditId:
            .managedSheet
        default:
            .push
        }
    }
}

public struct ___VARIABLE_modelName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_modelName___ListScreen.build()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .coreServices()
    }
}
