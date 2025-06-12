// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeResources
import OversizeRouter
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_modelName___ListScreen: View {
    
    // Environments
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud

    // States
    @State var viewState: ___VARIABLE_modelName___ListViewState
    let reducer: ___VARIABLE_modelName___ListReducer

    // Initial
    public init(viewState: ___VARIABLE_modelName___ListViewState, reducer: ___VARIABLE_modelName___ListReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        Page("List") {
            stateView(viewState.___VARIABLE_modelPluralVariableName___State)
        }
        .backgroundSecondary()
        #if os(iOS)
        .searchable(
            text: $viewModel.searchTerm,
            isSearch: $viewModel.isSearch
        )
        #elseif os(macOS)
        .searchable(text: $viewModel.searchTerm)
        #endif
        .onChange(of: viewState.searchTerm) {
            reducer.callAsFunction(.onChangeSearchTerm(oldValue: $0, newValue: $1))
        }
        .task(priority: .background) { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<[___VARIABLE_modelName___]>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(displayType: viewModel.displayType)
        case let .result(___VARIABLE_modelPluralVariableName___):
            if ___VARIABLE_modelPluralVariableName___.isEmpty {
                if viewModel.searchTerm.isEmpty {
                    ___VARIABLE_modelName___EmptyView(action: {})
                } else {
                    ContentView(
                        image: Illustration.Objects.search,
                        title: "Nothing found",
                        subtitle: "Try changing your search")
                        .multilineTextAlignment(.center)
                }

            } else {
                content(model, displayType: displayType)
            }
        case let .error(error):
            ErrorView(error)
        }
    }

    @ViewBuilder
    private func content(_ ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelName___) -> some View {
        switch displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: viewModel.isCompactRow) {
                        reducer.callAsFunction(.onTapDetailFile(___VARIABLE_modelVariableName___))
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        case .grid:
            LazyVGrid(columns: [.init(.adaptive(minimum: 320), spacing: 12)], spacing: 12) {
                ForEach(___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___) {
                        reducer.callAsFunction(.onTapDetailFile(___VARIABLE_modelVariableName___))
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        }
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Picker("Filter", selection: $viewState.storage.displayType) {
                ForEach(___VARIABLE_modelName___ListDisplayType.allCases) { type in
                    type.icon.icon()
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Button(role: .destructive, action: {  reducer.callAsFunction(.onTapDeleteFile(___VARIABLE_modelVariableName___)) }) {
            Label {
                Text(L10n.Button.delete)
            } icon: {
                Image.Base.delete.icon(.error)
            }
        }
    }
}

//#Preview("List") {
//    ___VARIABLE_modelName___ListScreen()
//}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list)

    ___VARIABLE_modelName___PlaceholderView(displayType: .grid)
}
