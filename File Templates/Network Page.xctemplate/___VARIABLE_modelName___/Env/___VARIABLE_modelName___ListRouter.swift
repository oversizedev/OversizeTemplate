// ___FILEHEADER___

/*
import SwiftUI
import OversizeRouter

public enum ___VARIABLE_routerDestinationType___: Routable {
   case ___VARIABLE_modelPluralVariableName___List
   case ___VARIABLE_modelVariableName___Create
   case ___VARIABLE_modelVariableName___Edit(___VARIABLE_modelName___)
   case ___VARIABLE_modelVariableName___EditId(String)
   case ___VARIABLE_modelVariableName___Detail(___VARIABLE_modelName___)
   case ___VARIABLE_modelVariableName___DetailId(String)
}

public extension ___VARIABLE_routerDestinationType___ {
   var id: String {
       switch self {
       case .___VARIABLE_modelPluralVariableName___List:
           "___VARIABLE_modelPluralVariableName___List"
       case .___VARIABLE_modelVariableName___Create:
           "___VARIABLE_modelVariableName___Create"
       case .___VARIABLE_modelVariableName___Edit:
           "___VARIABLE_modelVariableName___Edit"
       case .___VARIABLE_modelVariableName___EditId:
           "___VARIABLE_modelVariableName___Edit"
       case .___VARIABLE_modelVariableName___Detail:
           "___VARIABLE_modelVariableName___Detail"
       case .___VARIABLE_modelVariableName___DetailId:
           "___VARIABLE_modelVariableName___Detail"
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
       case let .___VARIABLE_modelVariableName___EditId(id):
           ___VARIABLE_modelName___EditScreen(.editId(id))
       case let .___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___):
           ___VARIABLE_modelName___DetailScreen(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
       case let .___VARIABLE_modelVariableName___DetailId(id):
           ___VARIABLE_modelName___DetailScreen(id: id)
       }
   }
}
*/
