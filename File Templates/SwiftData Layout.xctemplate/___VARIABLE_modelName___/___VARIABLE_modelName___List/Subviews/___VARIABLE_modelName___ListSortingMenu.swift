// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeLocalizable
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListSortingMenu: View {
    @Binding private var sort: [SortDescriptor<___VARIABLE_modelName___>]
    @State private var orderSelection: SortOrder = .forward
    @State private var sortSelection: ___VARIABLE_modelName___ListSortingType = .name

    public init(sort: Binding<[SortDescriptor<___VARIABLE_modelName___>]>) {
        _sort = sort
    }

    public var body: some View {
        Menu {
            sortView
            ascendingView

        } label: {
            Image.FilterAndSetting.FilterWithLine.mini.icon(.onSurfaceHighEmphasis, size: .medium)
        }
        .menuStyle(.button)
        .onChange(of: sortSelection) { _, _ in
            onSelectFilter()
        }
        .onChange(of: orderSelection) { _, _ in
            onSelectFilter()
        }
    }

    private var sortView: some View {
        Section {
            Picker(selection: $sortSelection, label: Text("Sorting by")) {
                ForEach(___VARIABLE_modelName___ListSortingType.allCases) { sortingType in
                    Text(sortingType.title)
                        .tag(sortingType)
                }
            }
            .pickerStyle(.inline)
        }
    }

    private var ascendingView: some View {
        Section {
            Picker(selection: $orderSelection, label: Text("Ascending options")) {
                ForEach([SortOrder.forward, SortOrder.reverse], id: \.self) { sortingType in
                    Text(sortingType.title)
                        .tag(sortingType)
                }
            }
            .labelsHidden()
            .pickerStyle(.inline)
        }
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___ListSortingMenu {
    private func onSelectFilter() {
        sort = sortSelection.sortDescriptor(order: orderSelection)
    }
}

// MARK: - SortOrder Extension

extension SortOrder {
    var title: String {
        switch self {
        case .forward:
            return "Ascending"
        case .reverse:
            return "Descending"
        }
    }
}