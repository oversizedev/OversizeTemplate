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
        NavigationLayoutView("List") {
            stateView(viewState.___VARIABLE_modelPluralVariableName___State)
        } background: {
            Color.backgroundPrimary
        } emptyContent: {
            emptyContent
        }
        .emptyContent(viewState.isEmptyContent)
        .toolbar(content: toolbarContent)
        .toolbarTitleDisplayMode(.inline)
        .searchable(
            text: $viewState.searchTerm,
            isPresented: $viewState.isSearch,
            placement: .navigationBarDrawer(displayMode: .automatic)
        )
        .alert(item: $viewState.alert) { $0.alert }
        .task(priority: .background) { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationTo($viewState.destination)
        .onChange(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm(oldValue: $0, newValue: $1))
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<[___VARIABLE_modelName___]>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(displayType: viewState.storage.displayType)
        case let .result(___VARIABLE_modelPluralVariableName___):
            content(___VARIABLE_modelPluralVariableName___)
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
                    ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: viewState.storage.isCompactRow) {
                        reducer.callAsFunction(.onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___))
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        case .grid:
            LazyVGrid(columns: [.init(.adaptive(minimum: 320), spacing: 12)], spacing: 12) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___) {
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
            ___VARIABLE_modelName___EmptyView(action: { reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___) })
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
                Picker("Display", selection: $viewState.storage.displayType) {
                    ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                        type.icon.icon()
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)

                Button {
                    reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___)
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
            }
        }

    #endif

    private func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Base.delete.icon(.error)
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
