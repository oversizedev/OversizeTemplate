//___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_modelName___ListViewState
    let reducer: Reducer<___VARIABLE_modelName___ListViewModel>

    // Initial
    @MainActor
    public init(viewState: ___VARIABLE_modelName___ListViewState, reducer: Reducer<___VARIABLE_modelName___ListViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(viewState.filterType.title) {
            stateView(viewState.___VARIABLE_modelPluralVariableName___State)
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: { toolbarContent })
        .toolbarTitleDisplayMode(.inline)
        .searchable(
            text: $viewState.searchTerm,
            isPresented: $viewState.isSearch,
            placement: .navigationBarDrawer(displayMode: .automatic),
        )
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .task(priority: .background) {
            reducer.callAsFunction(.onAppear)
        }
        .refreshable(action: {
            reducer.callAsFunction(.onRefresh)
        })
        .navigationMove($viewState.destination)
        .onChange(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm(oldValue: $0, newValue: $1))
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<[___VARIABLE_modelName___]>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(displayType: viewState.storage.displayType, gridSize: viewState.storage.gridSize)
        case let .result(___VARIABLE_modelPluralVariableName___):
            content(___VARIABLE_modelPluralVariableName___)
        case let .error(error):
            ErrorView(error: error)
        }
    }

    @ViewBuilder
    private func content(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> some View {
        if ___VARIABLE_modelPluralVariableName___.isEmpty {
            emptyContent
        } else {
            switch viewState.storage.displayType {
            case .list:
                LazyVStack(spacing: .zero) {
                    ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, viewOption: viewState.storage.viewOption) {
                            reducer.callAsFunction(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                        }
                        .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                    }
                }
            case .grid:
                LazyVGrid(columns: [.init(.adaptive(minimum: viewState.storage.gridSize.minimumWidth), spacing: 12)], spacing: 12) {
                    ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                        ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___, viewOption: viewState.storage.viewOption) {
                            reducer.callAsFunction(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                        }
                        .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                    }
                }
                .paddingContent()
            }
        }
    }

    private var emptyContent: some View {
        ___VARIABLE_modelName___EmptyView(
            filter: viewState.filterType,
            isSearch: !viewState.searchTerm.isEmpty,
            action: { reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___) },
        )
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___ListScreen {
    @ViewBuilder
    private func archiveButton() -> some View {
        if viewState.filterType != .archived {
            Button {
                reducer.callAsFunction(.onTapArchive___VARIABLE_modelName___s)
            } label: {
                Image.Delivery.delivery.icon()
            }
        }
    }

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
                },
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
            .onChange(of: viewState.filterType) {
                reducer.callAsFunction(.onChangeFilterType($1))
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
            archiveButton()

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
                .onChange(of: viewState.storage.viewOption) {
                    reducer.callAsFunction(.onChangeViewOption($1))
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
                        .onChange(of: viewState.storage.sortType) {
                            reducer.callAsFunction(.onChangeSortType($1))
                        }
                    }

                    Section("Sort order") {
                        Picker("Sort order", selection: $viewState.storage.sortOrder) {
                            ForEach(___VARIABLE_modelName___SortOrder.allCases) { order in
                                Text(order.title)
                                    .tag(order)
                            }
                        }
                        .onChange(of: viewState.storage.sortOrder) {
                            reducer.callAsFunction(.onChangeSortOrder($1))
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
                    .onChange(of: viewState.storage.viewOption) {
                        reducer.callAsFunction(.onChangeViewOption($1))
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
        }
    }
    #endif
}

// MARK: - Context menu

private extension ___VARIABLE_modelName___ListScreen {
    @ViewBuilder
    func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Button(action: { reducer.callAsFunction(.onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(L10n.Button.edit)
            } icon: {
                Image.Design.PencilAndSquare.mini
            }
        }

        Button(action: { reducer.callAsFunction(.onToggleFavorite(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(___VARIABLE_modelVariableName___.isFavorite ? "Unfavorite" : "Favorite")
            } icon: {
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.Unstar.mini

                } else {
                    Image.Base.Star.mini
                }
            }
        }

        Button(action: { reducer.callAsFunction(.onToggleArchive(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(___VARIABLE_modelVariableName___.isArchive ? L10n.Button.unarchive : L10n.Button.archive)
            } icon: {
                Image.Delivery.Delivery.mini
            }
        }

        Button(action: { reducer.callAsFunction(.onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text("Duplicate")
            } icon: {
                Image.Documentation.Copy.mini
            }
        }

        Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Editor.TrashWithLines.mini
            }
        }
    }
}

public extension ___VARIABLE_modelName___ListScreen {
    @MainActor
    static func build() -> some View {
        logNotice("Building ___VARIABLE_modelName___ListScreen")
        let viewState = ___VARIABLE_modelName___ListViewState()
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildArchive() -> some View {
        logNotice("Building ___VARIABLE_modelName___ListScreen (Archive)")
        let viewState = ___VARIABLE_modelName___ListViewState(filterType: .archived)
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildFavorites() -> some View {
        logNotice("Building ___VARIABLE_modelName___ListScreen (Favorites)")
        let viewState = ___VARIABLE_modelName___ListViewState(filterType: .favorites)
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview("List") {
    NavigationStack {
        ___VARIABLE_modelName___ListScreen.build()
    }
}

#Preview("Archive") {
    NavigationStack {
        ___VARIABLE_modelName___ListScreen.buildArchive()
    }
}

#Preview("Favorites") {
    NavigationStack {
        ___VARIABLE_modelName___ListScreen.buildFavorites()
    }
}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list)
    ___VARIABLE_modelName___PlaceholderView(displayType: .grid, gridSize: .medium)
}
