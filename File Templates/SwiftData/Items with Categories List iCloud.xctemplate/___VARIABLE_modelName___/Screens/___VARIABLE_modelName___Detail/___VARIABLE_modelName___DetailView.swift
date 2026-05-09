// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Detail.self)
public struct ___VARIABLE_modelName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationListCoverLayoutView {
            stateView(viewState.state)
        } cover: {
            cover
        } coverBackground: {
            coverBackground
        }
        .listLayoutStyle(.smallInsetGrouped)
        .toolbar { toolbarContent }
        .presentationAlert($viewState.alert)
        .presentationHUD($viewState.hud)
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
        .task { reducer.callAsFunction(.onAppear) }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___DetailViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            content(model.___VARIABLE_modelVariableName___)
        case let .error(error):
            ErrorView(error: error)
        }
    }

    private var cover: some View {
        HStack(spacing: .xxxSmall) {
            Text(viewState.state.result?.___VARIABLE_modelVariableName___.name ?? "")
                .title3()
                .onSurfacePrimary()
                .multilineTextAlignment(.center)

            if viewState.state.result?.___VARIABLE_modelVariableName___.isFavorite ?? false {
                Image.Base.Star.fill.icon(Color.warning)
            }
        }
    }

    @ViewBuilder
    private var coverBackground: some View {
        if let image = viewState.state.result?.___VARIABLE_modelVariableName___.image {
            GeometryReader { geometry in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
        } else {
            LinearGradient(
                colors: [
                    Color.backgroundPrimary,
                    Color.backgroundTertiary,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        ListSection {
            ListRow(___VARIABLE_modelVariableName___.date.formatted())
            if let note = ___VARIABLE_modelVariableName___.note {
                ListRow(note)
            }
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

                    if let ___VARIABLE_modelVariableName___ = viewState.state.result?.___VARIABLE_modelVariableName___ {
                        Menu {
                            Button(action: { reducer.callAsFunction(.onTapSelect___VARIABLE_categoryName___(nil)) }) {
                                Label {
                                    Text("No Category")
                                } icon: {
                                    if ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id == nil {
                                        Image.Base.Check.mini
                                    }
                                }
                            }

                            ForEach(viewState.state.result?.___VARIABLE_categoryPluralVariableName___ ?? []) { category in
                                Button(action: { reducer.callAsFunction(.onTapSelect___VARIABLE_categoryName___(category)) }) {
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

                            Button(action: { reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___) }) {
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
