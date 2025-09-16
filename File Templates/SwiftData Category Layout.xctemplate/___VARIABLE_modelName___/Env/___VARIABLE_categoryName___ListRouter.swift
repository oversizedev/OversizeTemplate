// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_categoryName___Destinations {
    case ___VARIABLE_categoryPluralVariableName___List
    case ___VARIABLE_categoryPluralVariableName___Archive
    case ___VARIABLE_categoryPluralVariableName___Favorites
    case detail(___VARIABLE_categoryName___)
    case create
    case edit(___VARIABLE_categoryName___)
    case archive
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
        case .archive:
            ___VARIABLE_categoryName___ListScreen.buildArchive()
        case let .detail(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryName___DetailScreen.build(___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___.id)
        case .create:
            ___VARIABLE_categoryName___EditScreen.buildCreate()
        case let .edit(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryName___EditScreen.buildEdit(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .create, .edit:
            .managedSheet
        default:
            .push
        }
    }
}

public struct ___VARIABLE_categoryName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_categoryName___ListScreen.build()
                .navigationDestinationAutoReceive(___VARIABLE_categoryName___Destinations.self)
        }
        .coreServices()
    }
}