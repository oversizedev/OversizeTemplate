// ___FILEHEADER___

import Database
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_modelName___Destinations {
    case mealProductsList
    case mealProductDetails(id: UUID)
    case mealProductDetails___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case mealProductCreate
    case mealProductEdit(id: UUID)
    case mealProductEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
}

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .mealProductsList:
            ___VARIABLE_modelName___ListScreen.build()
        case let .mealProductDetails(id):
            ___VARIABLE_modelName___DetailScreen.build(id: id)
        case let .mealProductDetails___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen.build(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case .mealProductCreate:
            ___VARIABLE_modelName___EditScreen.build()
        case let .mealProductEdit(id: id):
            ___VARIABLE_modelName___EditScreen.buildEdit(id: id)
        case let .mealProductEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___EditScreen.buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .mealProductCreate, .mealProductEdit, .mealProductEdit___VARIABLE_modelName___:
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
        .systemServices()
    }
}
