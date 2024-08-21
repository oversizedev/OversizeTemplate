// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeLocalizable
import OversizeUI
import SwiftData
import SwiftUI
import OversizeRouter

public struct ___VARIABLE_modelName___ListSortingScreen: View {
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router
    @Binding private var sort: [SortDescriptor<___VARIABLE_modelName___>]

    @State private var orderSelection: SortOrder = .forward
    @State private var sortSelection: ___VARIABLE_modelName___ListSortingType = .name

    public init(sort: Binding<[SortDescriptor<___VARIABLE_modelName___>]>) {
        _sort = sort
    }

    public var body: some View {
        Page("Sort by") {
            VStack(spacing: .zero) {
                sortView
                ascendingView
            }
            .surfaceContentRowMargins()
        }
        .backgroundSecondary()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: onTapClose) {
                    #if os(macOS)
                    Text(L10n.Button.cancel)
                    #else
                    Image.Base.close.icon()
                    #endif
                }
                #if !os(tvOS)
                .keyboardShortcut(.cancelAction)
                #endif
            }
        }
    }

    private var sortView: some View {
        SectionView {
            VStack(spacing: .zero) {
                ForEach(___VARIABLE_modelName___ListSortingType.allCases) { sortingType in
                    Radio(sortingType.title, isOn: sortingType == sortSelection) {
                        sortSelection = sortingType
                        onSelectFilter()
                    }
                }
            }
        }
    }

    private var ascendingView: some View {
        SectionView {
            VStack(spacing: .zero) {
                Radio("Ascending", isOn: orderSelection == .forward) {
                    orderSelection = .forward
                    onSelectFilter()
                }

                Radio("Descending", isOn: orderSelection == .reverse) {
                    orderSelection = .reverse
                    onSelectFilter()
                }
            }
        }
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___ListSortingScreen {
    private func onTapClose() {
        router.dismiss()
    }

    private func onSelectFilter() {
        sort = sortSelection.sortDescriptor(order: orderSelection)
    }
}

// MARK: - Sorting typs

enum ___VARIABLE_modelName___ListSortingType: String, CaseIterable, Identifiable {
    case name
    case date

    public var title: String {
        switch self {
        case .name:
            "Name"
        case .date:
            "Date"
        }
    }

    public func sortDescriptor(order: SortOrder) -> [SortDescriptor<___VARIABLE_modelName___>] {
        switch self {
        case .name:
            [SortDescriptor(\.name, order: order)]
        case .date:
            [SortDescriptor(\.date, order: order)]
        }
    }

    public var id: String { rawValue }
}
