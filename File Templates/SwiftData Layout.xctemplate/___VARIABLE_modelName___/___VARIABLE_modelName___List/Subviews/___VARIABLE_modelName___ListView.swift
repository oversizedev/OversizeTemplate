// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListView<Row>: View where Row: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [___VARIABLE_modelName___]
    private let searchTerm: String
    private let row: (___VARIABLE_modelName___) -> Row
    private let emptyAction: () -> Void
    private let type: ___VARIABLE_modelName___ListType

    public init(
        searchTerm: String = "",
        predicate: Predicate<___VARIABLE_modelName___>,
        sort: [SortDescriptor<___VARIABLE_modelName___>],
        type: ___VARIABLE_modelName___ListType = .list,
        emptyAction: @escaping () -> Void,
        @ViewBuilder row: @escaping (___VARIABLE_modelName___) -> Row
    ) {
        self._items = Query(
            filter: predicate,
            sort: sort
        )
        self.searchTerm = searchTerm
        self.emptyAction = emptyAction
        self.row = row
        self.type = type
    }

    public var body: some View {
        if items.isEmpty {
            if searchTerm.isEmpty {
                ___VARIABLE_modelName___EmptyView(action: emptyAction)
            } else {
                ContentView(
                    image: Illustration.Objects.search,
                    title: "Nothing found",
                    subtitle: "Try changing your search"
                )
                .multilineTextAlignment(.center)
            }

        } else {
            switch type {
            case .list:
                LazyVStack(spacing: .zero) {
                    ForEach(items) { ___VARIABLE_modelVariableName___ in
                        row(___VARIABLE_modelVariableName___)
                    }
                }
            case .grid:
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 40), spacing: 20), count: 4), alignment: .center, spacing: 2) {
                    ForEach(items) { ___VARIABLE_modelVariableName___ in
                        row(___VARIABLE_modelVariableName___)
                    }
                }
                .padding()
            }
        }
    }
}
