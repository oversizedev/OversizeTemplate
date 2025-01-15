 // ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeRouter
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___DetailScreen: View {
    /// Global
    @Environment(Router<___VARIABLE_routerDestinationType___>.self) var router: Router
    @Environment(AlertRouter.self) var alertRouter
    @Environment(HUDRouter.self) var hud: HUDRouter

    /// Local
    @State private var viewModel: ___VARIABLE_modelName___DetailViewModel

    /// Initialization
    public init(id: String) {
        viewModel = .init(id: id)
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        viewModel = .init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
    }

    public var body: some View {
        Page("Title", headerHeight: 240, onScroll: viewModel.onScroll) {
            stateView(viewModel.state)
        } header: {
            header
        }
        .backgroundSecondary()
        .toolbar(content: toolbarContent)
        .task(priority: .background, viewModel.onAppear)
        .refreshable(action: viewModel.onRefresh)
    }

    @ViewBuilder
    private func stateView(
        _ state: LoadingViewState<
            ___VARIABLE_modelName___DetailViewModel
                .StateModel
        >) -> some View
    {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            content(model)
        case let .error(error):
            ErrorView(error)
        }
    }

    private var header: some View {
        VStack {
            Text("Header")
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity)
        .background {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.ultraThinMaterial)

                LinearGradient(
                    colors: [
                        Color.surfacePrimary,
                        Color.surfaceSecondary,
                    ],
                    startPoint: .top,
                    endPoint: .bottom)

                Divider()
                    .opacity(1 - viewModel.headerVisibleRatio)
            }
        }
    }

    private func content(
        _: ___VARIABLE_modelName___DetailViewModel
            .StateModel) -> some View
    {
        LeadingVStack {
            Row("Text")
        }
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: deleteAction) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.trashWithLines.icon(
                        .onSurfaceSecondary,
                        size: .medium)
                }
            }
        }
        #else
        ToolbarItem(placement: .confirmationAction) {
            Menu {
                Button(action: deleteAction) {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Base.filter.icon()
                    }
                }

            } label: {
                Image.Base.more.icon()
            }
        }
        #endif
    }
}

// MARK: - Actions

public extension ___VARIABLE_modelName___DetailScreen {
    private func deleteAction() {
        alertRouter.present(.delete {
            Task {
                let result = await viewModel.delete___VARIABLE_modelName___()
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

#Preview("Detail") {
    ___VARIABLE_modelName___DetailScreen(id: "0")
}
