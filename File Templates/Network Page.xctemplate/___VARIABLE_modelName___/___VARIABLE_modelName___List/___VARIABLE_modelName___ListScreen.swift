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
    /// Global
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud

    /// Local
    @State private var viewModel: ___VARIABLE_modelName___ListViewModel = .init()

    /// Init
    public init() {}

    public var body: some View {
        Page("List") {
            stateView(viewModel.state, displayType: viewModel.displayType)
        }
        .backgroundSecondary()
        #if os(iOS)
            .searchable(
                text: $viewModel.searchTerm,
                isSearch: $viewModel.isSearch)
        #elseif os(macOS)
            .searchable(text: $viewModel.searchTerm)
        #endif
            .toolbar(content: toolbarContent)
            .onChange(of: viewModel.searchTerm, viewModel.onChangeSearchTerm)
            .task(priority: .background, viewModel.onAppear)
            .refreshable(action: viewModel.onRefresh)
    }

    @ViewBuilder
    private func stateView(
        _ state: LoadingViewState<___VARIABLE_modelName___StateModel>,
        displayType: ___VARIABLE_modelName___ListViewModel.DisplayType) -> some View
    {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___PlaceholderView(displayType: viewModel.displayType)
        case let .result(model):
            if model.___VARIABLE_modelPluralVariableName___.isEmpty {
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
    private func content(
        _ model: ___VARIABLE_modelName___StateModel,
        displayType: ___VARIABLE_modelName___ListViewModel.DisplayType) -> some View
    {
        switch displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(model.___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Row(___VARIABLE_modelVariableName___, isCompact: viewModel.isCompactRow) {
                        onTapDetail(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        case .grid:
            LazyVGrid(
                columns: [.init(.adaptive(minimum: 320), spacing: 12)],
                spacing: 12)
            {
                ForEach(model.___VARIABLE_modelPluralVariableName___) { ___VARIABLE_modelVariableName___ in
                    ___VARIABLE_modelName___Cell(___VARIABLE_modelVariableName___) {
                        onTapDetail(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
                    }
                    .contextMenu { contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
                }
            }
        }
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Picker("Filter", selection: $viewModel.displayType) {
                ForEach(___VARIABLE_modelName___ListViewModel.DisplayType.allCases) { type in
                    type.icon.icon()
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
        }
    }

    private func contextMenu(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        Group {
            Button(action: viewModel.onTapCompactRow) {
                Label {
                    Text(
                        viewModel
                            .displayType == .list ? "Compact row" :
                            "Compact cell")
                } icon: {
                    Image.GridsAndLayout.list.icon()
                }
            }

            Button(role: .destructive, action: { onTapDelete(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.delete.icon(.error)
                }
            }
        }
    }
}

// MARK: - Router Actions

extension ___VARIABLE_modelName___ListScreen {
    private func onTapDetail(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        router.move(.___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___))
    }

    private func onTapDelete(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        alertRouter.present(.delete {
            Task {
                let result = await viewModel.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
                switch result {
                case .success:
                    hud.present("Deleted", style: .delete)
                case .failure:
                    hud.present("Delete error", style: .destructive)
                }
            }
        })
    }
}

#Preview("List") {
    ___VARIABLE_modelName___ListScreen()
}

#Preview("Placeholders") {
    ___VARIABLE_modelName___PlaceholderView(displayType: .list)

    ___VARIABLE_modelName___PlaceholderView(displayType: .grid)
}
