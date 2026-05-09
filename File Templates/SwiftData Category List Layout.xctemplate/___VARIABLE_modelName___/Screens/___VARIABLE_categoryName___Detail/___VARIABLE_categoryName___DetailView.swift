// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

@View(module: ___VARIABLE_categoryName___Detail.self)
public struct ___VARIABLE_categoryName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationListCoverLayoutView(coverHeight: 200) {
            stateView(viewState.state)
        } cover: {
            cover
        } coverBackground: {
            coverBackground
        }
        .listLayoutStyle(.smallInsetGrouped)
        .toolbar { toolbarContent }
        .errorState(viewState.state)
        .presentationAlert($viewState.alert)
        .presentationHUD($viewState.hud)
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
        .task { reducer.callAsFunction(.onAppear) }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_categoryName___DetailViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_categoryName___DetailPlaceholder()
        case let .result(model):
            content(model)
        default:
            EmptyView()
        }
    }

    private var cover: some View {
        VStack(spacing: .xSmall) {
            Text(viewState.state.result?.___VARIABLE_categoryVariableName___.emoji ?? "🍏")
                .font(.system(size: 48))
                .padding(.large)
                .background {
                    Circle()
                        .fill(Color.surfacePrimary)
                }

            HStack(spacing: .xxxSmall) {
                Text(viewState.state.result?.___VARIABLE_categoryVariableName___.name ?? "")
                    .title3()
                    .onSurfacePrimary()
                    .multilineTextAlignment(.center)

                if viewState.state.result?.___VARIABLE_categoryVariableName___.isFavorite ?? false {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            }
        }
    }

    private var coverBackground: some View {
        LinearGradient(
            colors: [
                Color.backgroundPrimary,
                Color.backgroundSecondary,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    @ViewBuilder
    private func content(_ model: ___VARIABLE_categoryName___DetailViewState.StateModel) -> some View {
        ListSection("Information") {
            ListRow(
                "Name",
                subtitle: model.___VARIABLE_categoryVariableName___.name
            )
            if let note = model.___VARIABLE_categoryVariableName___.note, !note.isEmpty {
                ListRow(
                    "Note",
                    subtitle: note
                )
            }
        }

        if model.isEmpty {
            ListSection {
                TextBox(
                    title: "Nothing Here Yet",
                    subtitle: "Items you add will appear here"
                )
                .textBoxSize(.small)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.large)
            }
        } else {
            ___VARIABLE_modelName___ListContentView(
                ___VARIABLE_modelPluralVariableName___: model.___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: model.___VARIABLE_categoryPluralVariableName___,
                viewOption: .standard,
                onAction: { action in
                    reducer.callAsFunction(.on___VARIABLE_modelName___Action(action))
                }
            )
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___DetailView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        #if os(macOS)
            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: {
                    reducer.callAsFunction(.onTapDelete___VARIABLE_categoryName___)
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
                    Button(action: { reducer.callAsFunction(.onTapEdit___VARIABLE_categoryName___) }) {
                        Label {
                            Text(L10n.Button.edit)
                        } icon: {
                            Image.Design.PencilAndSquare.mini
                        }
                    }

                    if let ___VARIABLE_categoryVariableName___ = viewState.state.result?.___VARIABLE_categoryVariableName___ {
                        Button(action: { reducer.callAsFunction(.onTapToggleFavorite) }) {
                            Label {
                                Text(___VARIABLE_categoryVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                            } icon: {
                                if ___VARIABLE_categoryVariableName___.isFavorite {
                                    Image.Base.Unstar.mini
                                } else {
                                    Image.Base.Star.mini
                                }
                            }
                        }
                    }

                    Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete___VARIABLE_categoryName___) }) {
                        Label {
                            Text(L10n.Button.delete)
                        } icon: {
                            Image.Editor.TrashWithLines.mini
                        }
                        .tint(.error)
                    }

                } label: {
                    Image.Base.more.icon()
                }
                .tint(.onSurfacePrimary)
            }

        #endif
    }
}

#Preview("Detail") {
    ___VARIABLE_categoryName___DetailPlaceholder()
}

#Preview("Placeholder") {
    ___VARIABLE_categoryName___DetailPlaceholder()
}
