// ___FILEHEADER___

import Database
import Environment
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

public struct MealProductListScreen: View {
    // States
    @State var viewState: MealProductListViewState
    let reducer: MealProductListReducer

    // Initial
    public init(viewState: MealProductListViewState, reducer: MealProductListReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView("List") {
            stateView(viewState.mealProductsState)
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
        .task(priority: .background) { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationMove($viewState.destination)
        .onChange(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm(oldValue: $0, newValue: $1))
        }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<[MealProduct]>) -> some View {
        switch state {
        case .idle, .loading:
            MealProductPlaceholderView(displayType: viewState.storage.displayType)
        case let .result(mealProducts):
            content(mealProducts)
        case let .error(error):
            ErrorView(error)
        }
    }

    @ViewBuilder
    private func content(_ mealProducts: [MealProduct]) -> some View {
        switch viewState.storage.displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(mealProducts) { mealProduct in
                    MealProductRow(mealProduct, isCompact: viewState.storage.isCompactRow) {
                        reducer.callAsFunction(.onTapDetailMealProduct(mealProduct))
                    }
                    .contextMenu { contextMenu(mealProduct: mealProduct) }
                }
            }
        case .grid:
            LazyVGrid(columns: [.init(.adaptive(minimum: 320), spacing: 12)], spacing: 12) {
                ForEach(mealProducts) { mealProduct in
                    MealProductCell(mealProduct) {
                        reducer.callAsFunction(.onTapDetailMealProduct(mealProduct))
                    }
                    .contextMenu { contextMenu(mealProduct: mealProduct) }
                }
            }
        }
    }

    @ViewBuilder
    private var emptyContent: some View {
        if viewState.searchTerm.isEmpty {
            MealProductEmptyView(action: { reducer.callAsFunction(.onTapCreateMealProduct) })
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
                    ForEach(MealProductListDisplayType.allCases) { type in
                        type.icon.icon()
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)

                Button {
                    reducer.callAsFunction(.onTapCreateMealProduct)
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
                    reducer.callAsFunction(.onTapCreateMealProduct)
                } label: {
                    Image.Base.plus.icon()
                }

                Menu {
                    Picker("Display", selection: $viewState.storage.displayType) {
                        ForEach(MealProductListDisplayType.allCases) { type in
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

    private func contextMenu(mealProduct: MealProduct) -> some View {
        Button(role: .destructive, action: { reducer.callAsFunction(.onTapDeleteMealProduct(mealProduct)) }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Base.delete.icon(.error)
            }
        }
    }
}

public extension MealProductListScreen {
    static func build() -> some View {
        let viewState = MealProductListViewState()
        let viewModel = MealProductListViewModel(state: viewState)
        let reducer = MealProductListReducer(viewModel: viewModel)
        return MealProductListScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview("List") {
    NavigationStack {
        MealProductListScreen.build()
    }
}

#Preview("Placeholders") {
    MealProductPlaceholderView(displayType: .list)

    MealProductPlaceholderView(displayType: .grid)
}
