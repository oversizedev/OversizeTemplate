// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListScreen: View {
    // States
    @State var viewState: ___VARIABLE_modelName___ListViewState
    let reducer: ___VARIABLE_modelName___ListReducer

    // Initial
    public init(viewState: ___VARIABLE_modelName___ListViewState, reducer: ___VARIABLE_modelName___ListReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(title) {
            stateView(viewState.___VARIABLE_modelPluralVariableName___State)
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: toolbarContent)
        .toolbarTitleDisplayMode(.inline)
        .searchable(
            text: $viewState.searchTerm,
            isPresented: $viewState.isSearch,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search ___VARIABLE_modelPluralVariableName___..."
        )
        .alert(item: $viewState.alert) { $0.alert }
        .task(priority: .background) { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationMove($viewState.destination)
        .onChange(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm(oldValue: $0, newValue: $1))
        }
        .sheet(isPresented: $viewState.isShowingFilters) {
            filtersSheet
        }
        .sheet(isPresented: $viewState.isShowingSortOptions) {
            sortOptionsSheet
        }
        .sheet(isPresented: $viewState.isShowingViewOptions) {
            viewOptionsSheet
        }
    }

    private var title: String {
        if viewState.isSelectionMode {
            return viewState.hasSelectedItems ? "\(viewState.selectedCount) selected" : "Select Items"
        } else {
            switch viewState.storage.filterType {
            case .standard:
                return "___VARIABLE_modelName___"
            case .archived:
                return "Archived ___VARIABLE_modelName___"
            case .favorites:
                return "Favorite ___VARIABLE_modelName___"
            }
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<[___VARIABLE_modelName___]>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(
                displayType: viewState.storage.displayType,
                gridSize: viewState.storage.gridSize
            )
        case let .result(___VARIABLE_modelPluralVariableName___):
            if ___VARIABLE_modelPluralVariableName___.isEmpty {
                emptyContent
            } else {
                content(___VARIABLE_modelPluralVariableName___)
            }
        case let .error(error):
            ErrorView(error)
        }
    }

    @ViewBuilder
    private func content(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) -> some View {
        switch viewState.storage.displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Row(
                        ___VARIABLE_modelVariableName___,
                        isSelected: viewState.selectedItems.contains(___VARIABLE_modelVariableName___.id),
                        isCompact: viewState.storage.isCompactRow,
                        showImages: viewState.storage.showImages,
                        showNotes: viewState.storage.showNotes,
                        showDates: viewState.storage.showDates,
                        isSelectionMode: viewState.isSelectionMode
                    ) {
                        reducer.callAsFunction(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        case .grid:
            LazyVGrid(columns: viewState.storage.gridColumns, spacing: 12) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Cell(
                        ___VARIABLE_modelVariableName___,
                        isSelected: viewState.selectedItems.contains(___VARIABLE_modelVariableName___.id),
                        gridSize: viewState.storage.gridSize,
                        showImages: viewState.storage.showImages,
                        showNotes: viewState.storage.showNotes,
                        showDates: viewState.storage.showDates,
                        isSelectionMode: viewState.isSelectionMode
                    ) {
                        reducer.callAsFunction(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        }
    }

    @ViewBuilder
    private var emptyContent: some View {
        if viewState.searchTerm.isEmpty {
            ___VARIABLE_modelName___EmptyView(
                filterType: viewState.storage.filterType,
                action: { reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___) }
            )
        } else {
            ___VARIABLE_modelName___NotFoundView(searchTerm: viewState.searchTerm)
        }
    }

    // MARK: - Sheets

    @ViewBuilder
    private var filtersSheet: some View {
        NavigationView {
            List {
                Section("Filter Type") {
                    ForEach(___VARIABLE_modelName___ListFilterType.allCases) { filterType in
                        Button {
                            reducer.callAsFunction(.onTapFilterType(filterType))
                        } label: {
                            Label {
                                Text(filterType.title)
                            } icon: {
                                filterType.icon
                            }
                            .foregroundStyle(viewState.storage.filterType == filterType ? .primary : .secondary)
                        }
                    }
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewState.isShowingFilters = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    @ViewBuilder
    private var sortOptionsSheet: some View {
        NavigationView {
            List {
                Section("Sort By") {
                    ForEach(___VARIABLE_modelName___ListSortType.allCases) { sortType in
                        Button {
                            reducer.callAsFunction(.onTapSortType(sortType))
                        } label: {
                            Label {
                                Text(sortType.title)
                            } icon: {
                                sortType.icon
                            }
                            .foregroundStyle(viewState.storage.sortType == sortType ? .primary : .secondary)
                        }
                    }
                }
                
                Section("Sort Order") {
                    ForEach(___VARIABLE_modelName___ListSortOrder.allCases) { sortOrder in
                        Button {
                            reducer.callAsFunction(.onTapSortOrder(sortOrder))
                        } label: {
                            Label {
                                Text(sortOrder.title)
                            } icon: {
                                sortOrder.icon
                            }
                            .foregroundStyle(viewState.storage.sortOrder == sortOrder ? .primary : .secondary)
                        }
                    }
                }
            }
            .navigationTitle("Sort Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewState.isShowingSortOptions = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    @ViewBuilder
    private var viewOptionsSheet: some View {
        NavigationView {
            List {
                Section("Display Options") {
                    ForEach(___VARIABLE_modelName___ListViewOption.allCases) { option in
                        Toggle(isOn: Binding(
                            get: { viewState.storage.viewOptions.contains(option) },
                            set: { _ in reducer.callAsFunction(.onToggleViewOption(option)) }
                        )) {
                            Label {
                                Text(option.title)
                            } icon: {
                                option.icon
                            }
                        }
                    }
                }
                
                if viewState.storage.displayType == .grid {
                    Section("Grid Size") {
                        ForEach(___VARIABLE_modelName___ListGridSize.allCases) { gridSize in
                            Button {
                                reducer.callAsFunction(.onTapGridSize(gridSize))
                            } label: {
                                Label {
                                    Text(gridSize.title)
                                } icon: {
                                    gridSize.icon
                                }
                                .foregroundStyle(viewState.storage.gridSize == gridSize ? .primary : .secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("View Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewState.isShowingViewOptions = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    // MARK: - Toolbars

    #if os(macOS) || os(visionOS) || os(tvOS)
        @ToolbarContentBuilder
        private func toolbarContent() -> some ToolbarContent {
            ToolbarItemGroup(placement: .primaryAction) {
                if viewState.isSelectionMode {
                    selectionToolbar
                } else {
                    standardToolbar
                }
            }
        }
    #endif

    #if os(iOS) || os(watchOS)
        @ToolbarContentBuilder
        private func toolbarContent() -> some ToolbarContent {
            ToolbarItemGroup(placement: .primaryAction) {
                if viewState.isSelectionMode {
                    selectionToolbar
                } else {
                    standardToolbar
                }
            }
        }
    #endif

    @ViewBuilder
    private var standardToolbar: some View {
        #if os(macOS) || os(visionOS) || os(tvOS)
            Picker("Display", selection: $viewState.storage.displayType) {
                ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                    type.icon.icon()
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)

            Button {
                reducer.callAsFunction(.onTapToggleFilters)
            } label: {
                Image.Base.filter.icon()
            }

            Button {
                reducer.callAsFunction(.onTapToggleSortOptions)
            } label: {
                Image.Base.sort.icon()
            }

            Button {
                reducer.callAsFunction(.onTapToggleViewOptions)
            } label: {
                Image.Base.settings.icon()
            }

            Button {
                reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
            } label: {
                Image.Base.plus.icon()
            }
        #endif

        #if os(iOS) || os(watchOS)
            Button {
                reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
            } label: {
                Image.Base.plus.icon()
            }

            Menu {
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
                .pickerStyle(.menu)

                Divider()

                Button {
                    reducer.callAsFunction(.onTapToggleFilters)
                } label: {
                    Label {
                        Text("Filters")
                    } icon: {
                        Image.Base.filter.icon()
                    }
                }

                Button {
                    reducer.callAsFunction(.onTapToggleSortOptions)
                } label: {
                    Label {
                        Text("Sort")
                    } icon: {
                        Image.Base.sort.icon()
                    }
                }

                Button {
                    reducer.callAsFunction(.onTapToggleViewOptions)
                } label: {
                    Label {
                        Text("View Options")
                    } icon: {
                        Image.Base.settings.icon()
                    }
                }

                Divider()

                Button {
                    reducer.callAsFunction(.onTapSearch)
                } label: {
                    Label {
                        Text(L10n.Button.search)
                    } icon: {
                        Image.Base.search.icon()
                    }
                }

            } label: {
                Image.Base.more.icon()
            }
        #endif
    }

    @ViewBuilder
    private var selectionToolbar: some View {
        Button {
            reducer.callAsFunction(.onTapExitSelectionMode)
        } label: {
            Text("Cancel")
        }

        Button {
            reducer.callAsFunction(.onTapSelectAll)
        } label: {
            Text(viewState.isAllSelected ? "Deselect All" : "Select All")
        }

        if viewState.hasSelectedItems {
            Menu {
                Button {
                    reducer.callAsFunction(.onTapBatchFavorite(true))
                } label: {
                    Label("Add to Favorites", systemImage: "heart")
                }

                Button {
                    reducer.callAsFunction(.onTapBatchFavorite(false))
                } label: {
                    Label("Remove from Favorites", systemImage: "heart.slash")
                }

                Divider()

                Button {
                    reducer.callAsFunction(.onTapBatchArchive(true))
                } label: {
                    Label("Archive", systemImage: "archivebox")
                }

                Button {
                    reducer.callAsFunction(.onTapBatchArchive(false))
                } label: {
                    Label("Unarchive", systemImage: "archivebox.circle")
                }

                Divider()

                Button(role: .destructive) {
                    reducer.callAsFunction(.onTapBatchDelete)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
    }

    private func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Group {
            Button {
                reducer.callAsFunction(.onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            } label: {
                Label {
                    Text("Edit")
                } icon: {
                    Image.Base.edit.icon()
                }
            }

            Button {
                reducer.callAsFunction(.onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            } label: {
                Label {
                    Text("Duplicate")
                } icon: {
                    Image.Base.copy.icon()
                }
            }

            Divider()

            Button {
                reducer.callAsFunction(.onTapToggleFavorite___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            } label: {
                Label {
                    Text(___VARIABLE_modelVariableName___.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                } icon: {
                    Image.Base.heart.icon(___VARIABLE_modelVariableName___.isFavorite ? .error : .secondary)
                }
            }

            Button {
                reducer.callAsFunction(.onTapToggleArchive___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            } label: {
                Label {
                    Text(___VARIABLE_modelVariableName___.isArchive ? "Unarchive" : "Archive")
                } icon: {
                    Image.Base.archive.icon(.secondary)
                }
            }

            Divider()

            Button(role: .destructive) {
                reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            } label: {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.delete.icon(.error)
                }
            }
        }
    }
}

public extension ___VARIABLE_modelName___ListScreen {
    static func build() -> some View {
        let viewState = ___VARIABLE_modelName___ListViewState()
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___ListReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }
    
    static func buildArchive() -> some View {
        let viewState = ___VARIABLE_modelName___ListViewState()
        viewState.storage.filterType = .archived
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___ListReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }
    
    static func buildFavorites() -> some View {
        let viewState = ___VARIABLE_modelName___ListViewState()
        viewState.storage.filterType = .favorites
        let viewModel = ___VARIABLE_modelName___ListViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___ListReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___ListScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview("List") {
    NavigationStack {
        ___VARIABLE_modelName___ListScreen.build()
    }
}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list, gridSize: .medium)

    ___VARIABLE_modelName___PlaceholderView(displayType: .grid, gridSize: .medium)
}
