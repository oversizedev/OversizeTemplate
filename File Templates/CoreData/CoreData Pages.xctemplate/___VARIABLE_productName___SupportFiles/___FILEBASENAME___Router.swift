/*
// Screens
public enum Screen {
    case create___VARIABLE_productName___
    case update___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___)
    case detail___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___)
    case list___VARIABLE_productName___
    case sorting___VARIABLE_productName___(_ sortingTyps: [___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties], selection: Binding<___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties>, ascending: Binding<Bool>)
}

extension Screen: Identifiable {
    public var id: String {
        switch self {
        case .create___VARIABLE_productName___:
            return "create___VARIABLE_productName___"
        case .update___VARIABLE_productName___:
            return "update___VARIABLE_productName___"
        case .detail___VARIABLE_productName___:
            return "detail___VARIABLE_productName___"
        case .list___VARIABLE_productName___:
            return "list___VARIABLE_productName___"
        case .sorting___VARIABLE_productName___:
            return "sorting___VARIABLE_productName___"
        }
    }
}

// Resolve Router
extension Router {
    @ViewBuilder
    func resolve(pathItem: Screen) -> some View {
        switch pathItem {
        case .create___VARIABLE_productName___:
            ___VARIABLE_productName___CreateView(.create)
        case .update___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: let ___VARIABLE_CoreDataModelVariable___):
            ___VARIABLE_productName___CreateView(.update(___VARIABLE_CoreDataModelVariable___))
        case .detail___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: let ___VARIABLE_CoreDataModelVariable___):
            ___VARIABLE_productName___DetailView(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___)
        case .list___VARIABLE_productName___:
            ___VARIABLE_productName___Screen()
        case let .sorting___VARIABLE_productName___(types, selection: selection, ascending: ascending):
            ___VARIABLE_productName___SortingView(types, selection: selection, ascending: ascending)
    }
}
*/
