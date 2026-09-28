// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___List.self)
public struct ___VARIABLE_categoryName___ListView: ViewProtocol {
    public var body: some View {
        NavigationListLayout(viewState.filterType.title) {
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
                        Button("Add category") {
                            reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___)
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
        .navigationOpen($viewState.destination)
        .onChangeValue(of: viewState.searchTerm) { reducer.callAsFunction(.onChangeSearchTerm($0)) }
        .task { reducer.callAsFunction(.onAppear) }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_categoryName___ListViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_categoryName___PlaceholderView()
        case let .result(model):
            ___VARIABLE_categoryName___ListContentView(
                ___VARIABLE_categoryPluralVariableName___: model.___VARIABLE_categoryPluralVariableName___,
                viewOption: viewState.storage.viewOption,
                onAction: { reducer.callAsFunction(.onCategoryAction($0)) }
            )
        case .error:
            EmptyView()
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___ListView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            createButton
        }

        ToolbarItem(placement: .primaryAction) {
            optionsMenu
        }
    }

    private var createButton: some View {
        Button {
            reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___)
        } label: {
            Label {
                Text("Add category")
            } icon: {
                Image.Design.pencilAndSquare.icon()
            }
        }
        .tint(.onSurfacePrimary)
    }

    private var optionsMenu: some View {
        Menu {
            ___VARIABLE_categoryName___ListOptionsMenu(
                filterType: viewState.filterType,
                sortType: viewState.storage.sortType,
                sortOrder: viewState.storage.sortOrder,
                viewOption: viewState.storage.viewOption,
                onChangeFilterType: { reducer.callAsFunction(.onChangeFilterType($0)) },
                onChangeSortType: { reducer.callAsFunction(.onChangeSortType($0)) },
                onChangeSortOrder: { reducer.callAsFunction(.onChangeSortOrder($0)) },
                onChangeViewOption: { reducer.callAsFunction(.onChangeViewOption($0)) }
            )
        } label: {
            Label {
                Text("Options")
            } icon: {
                Image.Base.more.icon()
            }
        }
        .tint(.onSurfacePrimary)
    }
}

#Preview("List") {
    NavigationStack {
        ___VARIABLE_categoryName___List.build()
    }
}

#Preview("Placeholder") {
    List {
        ___VARIABLE_categoryName___PlaceholderView()
    }
}
