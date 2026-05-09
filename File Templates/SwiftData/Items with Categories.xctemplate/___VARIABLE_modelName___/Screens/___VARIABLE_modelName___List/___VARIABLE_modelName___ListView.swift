// ___FILEHEADER___

import Database
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
        NavigationLayoutView(viewState.filterType.title) {
            stateView(viewState.state)
        } background: {
            Color.backgroundPrimary
        }
        .toolbar { toolbarContent }
        .toolbarTitleDisplayMode(.inline)
        .searchable(
            text: $viewState.searchTerm,
            isPresented: $viewState.isSearch,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .emptyState(viewState.state) {
            EmptyStateView(
                image: viewState.isSearch ? Illustration.Objects.search : viewState.filterType.emptyStateImage,
                title: viewState.isSearch ? "Nothing found" : viewState.filterType.emptyStateTitle,
                subtitle: viewState.isSearch ? "Try changing your search" : viewState.filterType.emptyStateSubtitle,
                actions: {
                    if !viewState.isSearch {
                        Button("Add item") {
                            reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
                        }
                    }
                }
            )
        }
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationMove($viewState.destination)
        .onChangeValue(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm($0))
        }
        .task { reducer.callAsFunction(.onAppear) }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___ListViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(
                displayType: viewState.storage.displayType,
                gridSize: viewState.storage.gridSize
            )
        case let .result(model):
            ___VARIABLE_modelName___ListContentView(
                ___VARIABLE_modelPluralVariableName___: model.___VARIABLE_modelPluralVariableName___,
                categories: model.categories,
                displayType: viewState.storage.displayType,
                viewOption: viewState.storage.viewOption,
                gridSize: viewState.storage.gridSize,
                onAction: { reducer.callAsFunction(.onProductAction($0)) }
            )
        case let .error(error):
            ErrorView(error: error)
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___ListView {
    @ViewBuilder
    private func createButton() -> some View {
        Button {
            reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
        } label: {
            Image.Base.plus.icon()
        }
    }

    @ViewBuilder
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

            Picker("Display", selection: $viewState.storage.displayType) {
                ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                    type.icon.icon()
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)

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

            createButton()
        }
    }
    #endif

    #if os(iOS) || os(watchOS)
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            createButton()

            Menu {
                Section {
                    Picker("Display", selection: $viewState.storage.displayType) {
                        ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                            Label {
                                Text(type.title)
                            } icon: {
                                type.icon
                            }
                            .tag(type)
                        }
                    }
                }

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

                    Divider()

                    if viewState.storage.displayType == .grid {
                        Picker("Grid Size", selection: $viewState.storage.gridSize) {
                            ForEach(___VARIABLE_modelName___GridSize.allCases) { size in
                                Text(size.title)
                                    .tag(size)
                            }
                        }
                        .pickerStyle(.menu)
                    }

                } label: {
                    Text("View Options")
                    Text(viewState.storage.viewOption.title)
                }

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
        ___VARIABLE_modelName___List.build(input: ___VARIABLE_modelName___ListInput(categoryId: nil))
    }
}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list)
    ___VARIABLE_modelName___PlaceholderView(displayType: .grid, gridSize: .medium)
}
