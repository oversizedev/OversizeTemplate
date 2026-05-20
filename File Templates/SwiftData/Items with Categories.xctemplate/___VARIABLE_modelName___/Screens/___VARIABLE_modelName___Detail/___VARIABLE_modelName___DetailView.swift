// ___FILEHEADER___

import Database
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Detail.self)
public struct ___VARIABLE_modelName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationCoverLayoutView(viewState.___VARIABLE_modelVariableName___State.result?.name ?? "") {
            stateView(viewState.___VARIABLE_modelVariableName___State)
        } cover: {
            cover
        } contentBackground: {
            Color.backgroundPrimary
        } coverBackground: {
            coverBackground
        } background: {
            Color.backgroundPrimary
        }
        .toolbar { toolbarContent }
        .presentationAlert($viewState.alert)
        .presentationHUD($viewState.hud)
        .task { reducer.callAsFunction(.onAppear) }
        .refreshable { reducer.callAsFunction(.onRefresh) }
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
        Text("Cover")
    }

    private var coverBackground: some View {
        LinearGradient(
            colors: [
                Color.surfacePrimary,
                Color.blue,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack {
            Row(___VARIABLE_modelVariableName___.name)
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___DetailView {
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

                if let ___VARIABLE_modelVariableName___ = viewState.___VARIABLE_modelVariableName___State.result {
                    Menu {
                        Button(action: { reducer.callAsFunction(.onTapSelectCategory(nil)) }) {
                            Label {
                                Text("No Category")
                            } icon: {
                                if ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id == nil {
                                    Image.Base.Check.mini
                                }
                            }
                        }

                        ForEach(viewState.categoriesState.result ?? []) { category in
                            Button(action: { reducer.callAsFunction(.onTapSelectCategory(category)) }) {
                                Label {
                                    Text(category.name)
                                } icon: {
                                    if ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id == category.id {
                                        Image.Base.Check.mini
                                    }
                                }
                            }
                        }

                        Divider()

                        Button(action: { reducer.callAsFunction(.onTapCreateCategory) }) {
                            Label {
                                Text("Create Category")
                            } icon: {
                                Image.Base.Plus.mini
                            }
                        }
                    } label: {
                        Label {
                            Text("Category")
                        } icon: {
                            Image.Base.Folder.mini
                        }
                    }

                    Button(action: { reducer.callAsFunction(.onTapToggleFavorite) }) {
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
                }

                Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___) }) {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Editor.TrashWithLines.mini
                    }
                }
                .tint(.error)

            } label: {
                Image.Base.more.icon()
            }
            .tint(.onSurfacePrimary)
        }
        #endif
    }
}