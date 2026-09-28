// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___Detail.self)
public struct ___VARIABLE_categoryName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationListCoverLayout(coverHeight: 200) {
            stateView(viewState.state)
        } cover: {
            ___VARIABLE_categoryName___DetailCover(
                emoji: viewState.state.result?.___VARIABLE_categoryVariableName___.displayEmoji ?? ___VARIABLE_categoryName___.defaultEmoji,
                name: viewState.state.result?.___VARIABLE_categoryVariableName___.name ?? "",
                color: viewState.state.result?.___VARIABLE_categoryVariableName___.color ?? .clear,
                isFavorite: viewState.state.result?.___VARIABLE_categoryVariableName___.isFavorite ?? false
            )
        } coverBackground: {
            ___VARIABLE_categoryName___DetailCoverBackground(image: viewState.state.result?.___VARIABLE_categoryVariableName___.image)
        }
        .listLayoutStyle(.smallInsetGrouped)
        .contentMargins()
        .toolbar { toolbarContent }
        .errorState(viewState.state)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationOpen($viewState.destination)
        .navigationBack($viewState.isDismissed)
        .task { reducer.callAsFunction(.onAppear) }
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_categoryName___DetailViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_categoryName___DetailPlaceholder()
        case let .result(model):
            ___VARIABLE_categoryName___DetailContent(
                ___VARIABLE_categoryVariableName___: model.___VARIABLE_categoryVariableName___,
                ___VARIABLE_modelPluralVariableName___: model.___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: model.___VARIABLE_categoryPluralVariableName___,
                onTapCreate___VARIABLE_modelName___: { reducer.callAsFunction(.onTapCreate___VARIABLE_modelName___) },
                on___VARIABLE_modelName___Action: { reducer.callAsFunction(.on___VARIABLE_modelName___Action($0)) }
            )
        case .error:
            EmptyView()
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___DetailView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button {
                    reducer.callAsFunction(.onTapEdit)
                } label: {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Design.PencilAndSquare.mini
                    }
                }

                if let ___VARIABLE_categoryVariableName___ = viewState.state.result?.___VARIABLE_categoryVariableName___ {
                    Button {
                        reducer.callAsFunction(.onTapToggleFavorite)
                    } label: {
                        Label {
                            Text(___VARIABLE_categoryVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                        } icon: {
                            ___VARIABLE_categoryVariableName___.isFavorite ? Image.Base.Unstar.mini : Image.Base.Star.mini
                        }
                    }
                }

                Button(role: .destructive) {
                    reducer.callAsFunction(.onTapDelete)
                } label: {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Editor.TrashWithLines.mini
                    }
                }
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
}

#Preview("Detail") {
    NavigationStack {
        ___VARIABLE_categoryName___Detail.build(input: .init(id: UUID()))
    }
}

#Preview("Placeholder") {
    List {
        ___VARIABLE_categoryName___DetailPlaceholder()
    }
}
