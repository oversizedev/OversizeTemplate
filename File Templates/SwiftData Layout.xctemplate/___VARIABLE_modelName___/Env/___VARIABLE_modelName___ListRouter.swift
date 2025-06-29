// ___FILEHEADER___

import SwiftUI
import OversizeNavigation

public enum ___VARIABLE_routerDestinationType___: Routable {
    case ___VARIABLE_modelPluralVariableName___List
    case ___VARIABLE_modelPluralVariableName___ListSorting(sort: Binding<[SortDescriptor<___VARIABLE_modelName___>]>)
    case ___VARIABLE_modelVariableName___Create
    case ___VARIABLE_modelVariableName___Edit(___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___Detail(___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___SplitDetail(___VARIABLE_modelName___?)
}

public extension ___VARIABLE_routerDestinationType___ {
    var id: String {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            "___VARIABLE_modelPluralVariableName___List"
        case .___VARIABLE_modelPluralVariableName___ListSorting:
            "___VARIABLE_modelPluralVariableName___ListSorting"
        case .___VARIABLE_modelVariableName___Create:
            "___VARIABLE_modelVariableName___Create"
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___):
            "___VARIABLE_modelVariableName___Edit.\(___VARIABLE_modelVariableName___.id.uuidString)"
        case let .___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___):
            "___VARIABLE_modelVariableName___Detail.\(___VARIABLE_modelVariableName___.id.uuidString)"
        case let .___VARIABLE_modelVariableName___SplitDetail(___VARIABLE_modelVariableName___):
            "___VARIABLE_modelVariableName___SplitDetail.\(___VARIABLE_modelVariableName___?.id.uuidString ?? "empty")"
        }
    }
}

// Resolve Router
extension ___VARIABLE_routerDestinationType___ {
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___ListScreen()
        case .___VARIABLE_modelVariableName___Create:
            ___VARIABLE_modelName___EditScreen(.create)
        case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___EditScreen(.edit(___VARIABLE_modelVariableName___))
        case let .___VARIABLE_modelPluralVariableName___ListSorting(sort: sort):
            ___VARIABLE_modelName___ListSortingScreen(sort: sort)
        case let .___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case let .___VARIABLE_modelVariableName___SplitDetail(___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___SplitDetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }
}
