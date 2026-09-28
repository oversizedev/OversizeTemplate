// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___ListOptionsMenu: View {
    let filterType: ___VARIABLE_modelName___FilterType
    let sortType: ___VARIABLE_modelName___SortType
    let sortOrder: ___VARIABLE_modelName___SortOrder
    let viewOption: ___VARIABLE_modelName___ViewOption
    let onChangeFilterType: (___VARIABLE_modelName___FilterType) -> Void
    let onChangeSortType: (___VARIABLE_modelName___SortType) -> Void
    let onChangeSortOrder: (___VARIABLE_modelName___SortOrder) -> Void
    let onChangeViewOption: (___VARIABLE_modelName___ViewOption) -> Void

    var body: some View {
        Menu {
            Picker("Filter", selection: Binding(get: { filterType }, set: { onChangeFilterType($0) })) {
                ForEach(___VARIABLE_modelName___FilterType.allCases) { type in
                    Label {
                        Text(type.title)
                    } icon: {
                        type.icon
                    }
                    .tag(type)
                }
            }
        } label: {
            Text("Filter")
            Text(filterType.title)
        }

        Menu {
            Picker("Sort by", selection: Binding(get: { sortType }, set: { onChangeSortType($0) })) {
                ForEach(___VARIABLE_modelName___SortType.allCases) { type in
                    Text(type.title)
                        .tag(type)
                }
            }

            Picker("Sort order", selection: Binding(get: { sortOrder }, set: { onChangeSortOrder($0) })) {
                ForEach(___VARIABLE_modelName___SortOrder.allCases) { order in
                    Text(order.title)
                        .tag(order)
                }
            }
        } label: {
            Text("Sort by")
            Text(sortType.title)
        }

        Menu {
            Picker("View options", selection: Binding(get: { viewOption }, set: { onChangeViewOption($0) })) {
                ForEach(___VARIABLE_modelName___ViewOption.allCases) { option in
                    Text(option.title)
                        .tag(option)
                }
            }
        } label: {
            Text("View options")
            Text(viewOption.title)
        }
    }
}

#Preview {
    Menu("Options") {
        ___VARIABLE_modelName___ListOptionsMenu(
            filterType: .standard,
            sortType: .date,
            sortOrder: .descending,
            viewOption: .standard,
            onChangeFilterType: { _ in },
            onChangeSortType: { _ in },
            onChangeSortOrder: { _ in },
            onChangeViewOption: { _ in }
        )
    }
}
