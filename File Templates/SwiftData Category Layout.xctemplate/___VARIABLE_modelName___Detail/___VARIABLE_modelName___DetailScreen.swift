//___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___DetailScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_modelName___DetailViewState
    let reducer: Reducer<___VARIABLE_modelName___DetailViewModel>

    // Initial
    @MainActor
    public init(viewState: ___VARIABLE_modelName___DetailViewState, reducer: Reducer<___VARIABLE_modelName___DetailViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationCoverLayoutView("Detail") {
            stateView(viewState.___VARIABLE_modelVariableName___State)
        } cover: {
            cover
        } background: {
            Color.backgroundPrimary
        }
        .toolbar { toolbarContent }
        .presentationAlert($viewState.alert)
        .presentationHUD($viewState.hud)
        .task {
            reducer.callAsFunction(.onAppear)
        }
        .refreshable(action: {
            reducer.callAsFunction(.onRefresh)
        })
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            content(model)
        case let .error(error):
            ErrorView(error: error)
        }
    }

    private var cover: some View {
        VStack {
            Text("Cover")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [
                    Color.surfacePrimary,
                    Color.blue,
                ],
                startPoint: .top,
                endPoint: .bottom,
            )
        }
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack {
            Row(___VARIABLE_modelVariableName___.name)
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___DetailScreen {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: {
                reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___)
            }) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.TrashWithLines.mini
                }
            }
        }
        #else
        ToolbarItem(placement: .confirmationAction) {
            Menu {
                Button(action: { reducer.callAsFunction(.onTapEdit___VARIABLE_modelName___) }) {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Design.PencilAndSquare.mini
                    }
                }

                if let ___VARIABLE_modelVariableName___ = viewState.___VARIABLE_modelVariableName___State.successResult {
                    Button(action: { reducer.callAsFunction(.onToggleFavorite) }) {
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

                    Button(action: { reducer.callAsFunction(.onToggleArchive) }) {
                        Label {
                            Text(___VARIABLE_modelVariableName___.isArchive ? L10n.Button.unarchive : L10n.Button.archive)
                        } icon: {
                            Image.Delivery.Delivery.mini
                        }
                    }
                }

                Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___) }) {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Editor.TrashWithLines.mini
                    }
                }

            } label: {
                Image.Base.more.icon()
            }
        }
        #endif
    }
}

// MARK: - Build Methods

public extension ___VARIABLE_modelName___DetailScreen {
    @MainActor
    static func build(id: UUID) -> some View {
        logNotice("Building ___VARIABLE_modelName___DetailScreen for ID: \(id)")
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___Id: id)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func build(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        logNotice("Building ___VARIABLE_modelName___DetailScreen for ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}
