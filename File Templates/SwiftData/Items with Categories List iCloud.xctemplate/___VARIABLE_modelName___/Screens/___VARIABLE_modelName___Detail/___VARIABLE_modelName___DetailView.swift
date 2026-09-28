// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Detail.self)
public struct ___VARIABLE_modelName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationListCoverLayout(coverHeight: 200) {
            stateView(viewState.state)
        } cover: {
            ___VARIABLE_modelName___DetailCover(
                name: viewState.state.result?.___VARIABLE_modelVariableName___.name ?? "",
                isFavorite: viewState.state.result?.___VARIABLE_modelVariableName___.isFavorite ?? false
            )
        } coverBackground: {
            ___VARIABLE_modelName___DetailCoverBackground(image: viewState.state.result?.___VARIABLE_modelVariableName___.image)
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
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___DetailViewState.StateModel>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            ___VARIABLE_modelName___DetailContent(
                ___VARIABLE_modelVariableName___: model.___VARIABLE_modelVariableName___,
                ___VARIABLE_categoryVariableName___Name: model.___VARIABLE_categoryVariableName___?.name
            )
        case .error:
            EmptyView()
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___DetailView {
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

                if let model = viewState.state.result {
                    categoryMenu(model)

                    Button {
                        reducer.callAsFunction(.onTapToggleFavorite)
                    } label: {
                        Label {
                            Text(model.___VARIABLE_modelVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                        } icon: {
                            model.___VARIABLE_modelVariableName___.isFavorite ? Image.Base.Unstar.mini : Image.Base.Star.mini
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
                    .tint(.error)
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

    private func categoryMenu(_ model: ___VARIABLE_modelName___DetailViewState.StateModel) -> some View {
        ___VARIABLE_categoryName___Menu(
            selected___VARIABLE_categoryName___Id: model.___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id,
            ___VARIABLE_categoryPluralVariableName___: model.___VARIABLE_categoryPluralVariableName___,
            onSelect___VARIABLE_categoryName___: { reducer.callAsFunction(.onTapSelectCategory($0)) },
            onTapCreate___VARIABLE_categoryName___: { reducer.callAsFunction(.onTapCreateCategory) }
        )
    }
}

#Preview("Detail") {
    NavigationStack {
        ___VARIABLE_modelName___Detail.build(input: .init(id: UUID()))
    }
}

#Preview("Placeholder") {
    List {
        ___VARIABLE_modelName___DetailPlaceholder()
    }
}
