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

public struct ___VARIABLE_modelName___ListScreen: View, ViewProtocol {
    // States
    @State var viewState: ___VARIABLE_modelName___ListViewState
    let reducer: Reducer<___VARIABLE_modelName___ListViewModel>

    // Initial
    public init(viewState: ___VARIABLE_modelName___ListViewState, reducer: Reducer<___VARIABLE_modelName___ListViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView("List") {
            stateView(viewState.___VARIABLE_modelPluralVariableName___State)
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: toolbarContent)
        .toolbarTitleDisplayMode(.inline)
        .searchable(
            text: $viewState.searchTerm,
            isPresented: $viewState.isSearch,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .alert(item: $viewState.alert) { $0.alert }
        .task(priority: .background) { 
            await reducer(.onAppear)
        }
        .refreshable {
            await reducer(.onRefresh)
        }
        .navigationMove($viewState.destination)
        .onChange(of: viewState.searchTerm) {
            Task {
                await reducer(.onChangeSearchTerm(oldValue: $0, newValue: $1))
            }
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<[___VARIABLE_modelName___]>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(displayType: viewState.storage.displayType)
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
                        isCompact: viewState.storage.isCompactRow,
                        viewOption: viewState.viewOption
                    ) {
                        Task {
                            await reducer(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                        }
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        swipeActions(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
                    }
                }
            }
        case .grid:
            let columns = Array(repeating: GridItem(.adaptive(minimum: viewState.storage.gridSize.minWidth), spacing: 12), count: viewState.storage.gridSize.columnCount)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___, viewOption: viewState.viewOption) {
                        Task {
                            await reducer(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                        }
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        }
    }

    @ViewBuilder
    private var emptyContent: some View {
        if viewState.searchTerm.isEmpty {
            ___VARIABLE_modelName___EmptyView {
                Task {
                    await reducer(.onTapCreate___VARIABLE_modelName___)
                }
            }
        } else {
            ContentView(
                image: Illustration.Objects.search,
                title: "Nothing found",
                subtitle: "Try changing your search"
            )
            .multilineTextAlignment(.center)
        }
    }

    #if os(macOS) || os(visionOS) || os(tvOS)
        @ToolbarContentBuilder
        private func toolbarContent() -> some ToolbarContent {
            ToolbarItemGroup(placement: .primaryAction) {
                Menu {
                    sortingAndFilteringMenu()
                } label: {
                    Image.Base.filter.icon()
                }
                
                Picker("Display", selection: $viewState.storage.displayType) {
                    ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                        type.icon.icon()
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)

                Button {
                    Task {
                        await reducer(.onTapCreate___VARIABLE_modelName___)
                    }
                } label: {
                    Image.Base.plus.icon()
                }
            }
        }
    #endif

    #if os(iOS) || os(watchOS)
        @ToolbarContentBuilder
        private func toolbarContent() -> some ToolbarContent {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    Task {
                        await reducer(.onTapCreate___VARIABLE_modelName___)
                    }
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
                    
                    sortingAndFilteringMenu()

                    Divider()
                    
                    Button {
                        Task {
                            await reducer(.onTapSearch)
                        }
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
            }
        }

    #endif
    
    @ViewBuilder
    private func sortingAndFilteringMenu() -> some View {
        Section("Sort") {
            Picker("Sort Type", selection: $viewState.storage.sortType) {
                ForEach(___VARIABLE_modelName___SortType.allCases) { sortType in
                    Label {
                        Text(sortType.title)
                    } icon: {
                        sortType.icon
                    }
                    .tag(sortType)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: viewState.storage.sortType) {
                Task {
                    await reducer(.onTapSortType($1))
                }
            }
            
            Picker("Sort Order", selection: $viewState.storage.sortOrder) {
                Label("Ascending", systemImage: "arrow.up")
                    .tag(SortOrder.forward)
                Label("Descending", systemImage: "arrow.down")
                    .tag(SortOrder.reverse)
            }
            .pickerStyle(.menu)
        }
        
        Section("Filter") {
            Picker("Filter Type", selection: $viewState.storage.filterType) {
                ForEach(___VARIABLE_modelName___FilterType.allCases) { filterType in
                    Label {
                        Text(filterType.title)
                    } icon: {
                        filterType.icon
                    }
                    .tag(filterType)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: viewState.storage.filterType) {
                Task {
                    await reducer(.onTapFilterType($1))
                }
            }
        }
    }

    private func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Group {
            Button {
                Task {
                    await reducer(.onToggleFavorite(___VARIABLE_modelVariableName___))
                }
            } label: {
                Label {
                    Text(___VARIABLE_modelVariableName___.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                } icon: {
                    Image.Base.heart.icon(___VARIABLE_modelVariableName___.isFavorite ? .error : .onSurfaceHighEmphasis)
                }
            }
            
            Button {
                Task {
                    await reducer(.onToggleArchive(___VARIABLE_modelVariableName___))
                }
            } label: {
                Label {
                    Text(___VARIABLE_modelVariableName___.isArchive ? "Unarchive" : "Archive")
                } icon: {
                    Image.Base.archive.icon()
                }
            }
            
            Divider()
            
            Button(role: .destructive) {
                Task {
                    await reducer(.onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                }
            } label: {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.delete.icon(.error)
                }
            }
        }
    }
    
    @ViewBuilder
    private func swipeActions(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Button {
            Task {
                await reducer(.onToggleFavorite(___VARIABLE_modelVariableName___))
            }
        } label: {
            Image.Base.heart.icon()
        }
        .tint(___VARIABLE_modelVariableName___.isFavorite ? .red : .orange)
        
        Button {
            Task {
                await reducer(.onToggleArchive(___VARIABLE_modelVariableName___))
            }
        } label: {
            Image.Base.archive.icon()
        }
        .tint(.blue)
        
        Button(role: .destructive) {
            Task {
                await reducer(.onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
            }
        } label: {
            Image.Base.delete.icon()
        }
        .tint(.red)
    }
}

public extension ___VARIABLE_modelName___ListScreen {
    static func build() -> some View {
        let viewState = ___VARIABLE_modelName___ListViewState()
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

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list)

    ___VARIABLE_modelName___PlaceholderView(displayType: .grid)
}
