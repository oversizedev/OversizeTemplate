//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryListView.swift, created on 27.07.2025
//

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

@View(module: MealProductCategoryList.self)
public struct MealProductCategoryListView: ViewProtocol {
    public var body: some View {
        NavigationLayoutView(viewState.filterType.title) {
            stateView(viewState.mealProductCategoriesState)
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
        .onChangeValue(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm($0))
        }
    }

    @ViewBuilder
    private func stateView(_ state: SearchableLoadingState<[MealProductCategory]>) -> some View {
        switch state {
        case .idle, .loading, .search:
            MealProductCategoryPlaceholderView(
                displayType: viewState.storage.displayType,
                gridSize: viewState.storage.gridSize
            )
        case let .result(mealProductCategories), let .searchResult(_, mealProductCategories):
            content(mealProductCategories)
        case .searchEmpty:
            EmptyStateView(
                image: Illustration.Objects.search,
                title: "Nothing found",
                subtitle: "Try changing your search"
            )
        case let .error(error):
            ErrorView(error: error)
        case .empty:
            EmptyStateView(
                image: viewState.filterType.emptyStateImage,
                title: viewState.filterType.emptyStateTitle,
                subtitle: viewState.filterType.emptyStateSubtitle,
                actions: {
                    if viewState.filterType == .standard {
                        Button("Add item") {
                            reducer.callAsFunction(.onTapCreateMealProductCategory)
                        }
                    }
                }
            )
        }
    }

    @ViewBuilder
    private func content(_ mealProductCategories: [MealProductCategory]) -> some View {
        MealProductCategoryListContentView(
            mealProductCategories: mealProductCategories,
            displayType: viewState.storage.displayType,
            viewOption: viewState.storage.viewOption,
            gridSize: viewState.storage.gridSize,
            onAction: { reducer.callAsFunction(.onCategoryAction($0)) }
        )
    }
}

// MARK: - Toolbar

private extension MealProductCategoryListView {
    @ViewBuilder
    private func createButton() -> some View {
        Button {
            reducer.callAsFunction(.onTapCreateMealProductCategory)
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
                Text(MealProductCategoryFilterType.standard.title)
            }

            Separator()

            Picker("Filter", selection: $viewState.filterType) {
                ForEach(MealProductCategoryFilterType.allCases.dropFirst()) { type in
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
                ForEach(MealProductCategoryListDisplayType.allCases) { type in
                    type.icon.icon()
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)

            Menu {
                Picker("View Option", selection: $viewState.storage.viewOption) {
                    ForEach(MealProductCategoryViewOption.allCases) { view in
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
                        ForEach(MealProductCategoryListDisplayType.allCases) { type in
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
                            ForEach(MealProductCategorySortType.allCases) { type in
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
                            ForEach(MealProductCategorySortOrder.allCases) { order in
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
                        ForEach(MealProductCategoryViewOption.allCases) { view in
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
                            ForEach(MealProductCategoryGridSize.allCases) { size in
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
                Image.Base.more
            }
            .tint(.onSurfacePrimary)
        }
    }
    #endif
}

#Preview("List") {
    NavigationStack {
        MealProductCategoryList.build()
    }
}

#Preview("Placeholders") {
    MealProductCategoryPlaceholderView(displayType: .list)
    MealProductCategoryPlaceholderView(displayType: .grid, gridSize: .medium)
}
