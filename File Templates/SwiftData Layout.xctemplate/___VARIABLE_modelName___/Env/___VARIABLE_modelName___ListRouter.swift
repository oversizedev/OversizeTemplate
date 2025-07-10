// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_modelName___Destinations {
    case ___VARIABLE_modelPluralVariableName___List
    case ___VARIABLE_modelVariableName___Details(id: UUID)
    case ___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___create
    case ___VARIABLE_modelVariableName___Edit(id: UUID)
    case ___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
}

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___ListScreen.build()
        case let .___VARIABLE_modelVariableName___Details(id):
            ___VARIABLE_modelName___DetailScreen.build(id: id)
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen.build(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case .___VARIABLE_modelVariableName___create:
            ___VARIABLE_modelName___EditScreen.build()
        case let .___VARIABLE_modelVariableName___Edit(id: id):
            ___VARIABLE_modelName___EditScreen.buildEdit(id: id)
        case let .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___EditScreen.buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_modelVariableName___create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___:
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
