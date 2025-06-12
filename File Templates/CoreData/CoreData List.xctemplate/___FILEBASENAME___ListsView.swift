// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___<Label>: View where Label: View {
    @FetchRequest var ___VARIABLE_CoreDataModelVariableMany___: FetchedResults<___VARIABLE_CoreDataModel___>
    @Binding var searchQuery: String
    @Binding var state:  ___VARIABLE_productName:identifier___ViewModel.State
    private let label: (___VARIABLE_CoreDataModel___) -> Label

    init(sorting: ___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties,
         sortingAscending: Bool = true,
         searchQuery: Binding<String>,
         state: Binding<___VARIABLE_productName:identifier___ViewModel.State>,
         limit: Int = 0,
         @ViewBuilder row: @escaping (___VARIABLE_CoreDataModel___) -> Label)
    {
        let fetchRequest = FetchRequest(fetchRequest: ___VARIABLE_CoreDataModel___.fetch(sort: sorting, ascending: sortingAscending, limit: limit))
        _ ___VARIABLE_CoreDataModelVariableMany___ = fetchRequest
        _searchQuery = searchQuery
        _state = state
        label = row
    }

    var body: some View {
        content(___VARIABLE_CoreDataModelVariableMany___)
            .onChange(of: searchQuery) { search___VARIABLE_CoreDataModel___(query: $0) }
            .onAppear {
                if ___VARIABLE_CoreDataModelVariableMany___.isEmpty {
                    state = .empty
                }
            }
    }

    @ViewBuilder
    private func content(_ ___VARIABLE_CoreDataModelVariableMany___: FetchedResults<___VARIABLE_CoreDataModel___>) -> some View {
        LazyVStack(spacing: .zero) {
            ForEach(___VARIABLE_CoreDataModelVariableMany___) { item in
                label(item)
            }
        }
    }

    func search___VARIABLE_CoreDataModel___(query: String) {
        ___VARIABLE_CoreDataModelVariableMany___.nsPredicate = !query.isEmpty ? ___VARIABLE_CoreDataModel___.searchPredicate(query: query, field: .name) : .all
    }
}
