// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_modelName___Destinations {
    case list
    case details(id: String)
    case details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case create
    case edit(id: String)
    case edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
}

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .list:
            ___VARIABLE_modelName___ListScreen.build()
        case let .details(id):
            ___VARIABLE_modelName___DetailScreen.build(id: id)
        case let .details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen.build(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case .create:
            ___VARIABLE_modelName___EditScreen.build()
        case let .edit(id: id):
            ___VARIABLE_modelName___EditScreen.buildEdit(id: id)
        case let .edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___EditScreen.buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .create, .edit, .edit___VARIABLE_modelName___:
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
