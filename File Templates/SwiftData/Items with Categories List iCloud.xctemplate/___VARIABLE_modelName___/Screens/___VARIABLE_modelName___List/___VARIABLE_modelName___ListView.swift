// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

@View(module: ___VARIABLE_modelName___List.self)
public struct ___VARIABLE_modelName___ListView: ViewProtocol {
    public var body: some View {
        NavigationListLayoutView(viewState.filterType.title) {
            stateView(viewState.state)
        }
        .listLayoutStyle(.smallInsetGrouped)
        .contentUnavailable(viewState.state) {
            EmptyStateView(
                image: viewState.filterType.emptyStateImage,
                title: viewState.filterType.emptyStateTitle,
                subtitle: viewState.filterType.emptyStateSubtitle,
                actions: {
                    if viewState.filterType == .standard {
                        Button("Add item") {
                            reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
                        }
                    }
                }
            )
        } search: {
            EmptyStateView(
                image: Illustration.Objects.search,
                title: "Nothing found",
                subtitle: "Try changing your search"
            )
        }
        .searchable(text: $viewState.searchTerm)
        .toolbar { toolbarContent }
        .toolbarTitleDisplayMode(.inline)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationMove($viewState.destination)
        .onChangeValue(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm($0))
        }
        .task {
            reducer.callAsFunction(.onAppear)
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___ListViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView()
        case let .result(model):
            ___VARIABLE_modelName___ListContentView(
                ___VARIABLE_modelPluralVariableName___: model.___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: model.___VARIABLE_categoryPluralVariableName___,
                viewOption: viewState.storage.viewOption,
                onAction: { reducer.callAsFunction(.onProductAction($0)) }
            )
        default:
            EmptyView()
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___ListView {
    private var createButton: some View {
        Button {
            reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
        } label: {
            Icon(Image.Design.pencilAndSquare)
        }
    }

    private func filterPicker() -> some View {
        Menu {
            Toggle(isOn: Binding(
                get: { viewState.filterType == .standard },
                set: { isOn in
                    if isOn {
                        reducer.callAsFunction(.onChangeFilterType(.standard))
                    }
                }
            )) {
                Text(___VARIABLE_modelName___FilterType.standard.title)
            }

            Separator()

            Picker("Filter", selection: $viewState.filterType) {
                ForEach(___VARIABLE_modelName___FilterType.allCases.dropFirst()) { type in
                    Label {
                        Text(type.title)
                    } icon: {
                        type.icon
                    }
                    .tag(type)
                }
            }
            .onChangeValue(of: viewState.filterType) {
                reducer.callAsFunction(.onChangeFilterType($0))
            }
        } label: {
            Text("Filter")

            if viewState.filterType != .standard {
                Text(viewState.filterType.title)
            }
        }
        .tint(.onSurfacePrimary)
    }

    private func sortingMenu() -> some View {
        Menu {
            Section("Sort by \(viewState.storage.sortType.title)") {
                Picker("Sort by", selection: $viewState.storage.sortType) {
                    ForEach(___VARIABLE_modelName___SortType.allCases) { type in
                        Text(type.title)
                            .tag(type)
                    }
                }
                .onChangeValue(of: viewState.storage.sortType) {
                    reducer.callAsFunction(.onChangeSortType($0))
                }
            }

            Section("Sort order") {
                Picker("Sort order", selection: $viewState.storage.sortOrder) {
                    ForEach(___VARIABLE_modelName___SortOrder.allCases) { order in
                        Text(order.title)
                            .tag(order)
                    }
                }
                .onChangeValue(of: viewState.storage.sortOrder) {
                    reducer.callAsFunction(.onChangeSortOrder($0))
                }
            }
        } label: {
            Text("Sort by")
            Text(viewState.storage.sortType.title)
        }
    }

    private func viewOptionMenu() -> some View {
        Menu {
            Picker("View Option", selection: $viewState.storage.viewOption) {
                ForEach(___VARIABLE_modelName___ViewOption.allCases) { view in
                    Text(view.title)
                        .tag(view)
                }
            }
            .onChangeValue(of: viewState.storage.viewOption) {
                reducer.callAsFunction(.onChangeViewOption($0))
            }
        } label: {
            Text("View Options")
            Text(viewState.storage.viewOption.title)
        }
    }

    #if os(macOS) || os(visionOS) || os(tvOS)
        @ToolbarContentBuilder
        private var toolbarContent: some ToolbarContent {
            ToolbarItemGroup(placement: .primaryAction) {
                Menu {
                    filterPicker()
                } label: {
                    Text(viewState.filterType.title)
                }

                viewOptionMenu()

                createButton
            }
        }
    #endif

    #if os(iOS) || os(watchOS)
        @ToolbarContentBuilder
        private var toolbarContent: some ToolbarContent {
            if #available(iOS 26.0, *) {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    createButton
                }
            } else {
                ToolbarItem(placement: .primaryAction) {
                    createButton
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Menu {
                    sortingMenu()

                    viewOptionMenu()

                    Section {
                        filterPicker()
                    }
                } label: {
                    Image.Base.more.icon()
                }
                .tint(.onSurfacePrimary)
            }
        }
    #endif
}

#Preview("List") {
    NavigationStack {
        ___VARIABLE_modelName___List.build()
    }
}

#Preview("Favorites") {
    NavigationStack {
        ___VARIABLE_modelName___List.build(input: ___VARIABLE_modelName___ListInput(___VARIABLE_categoryVariableName___Id: nil))
    }
}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView()
}
