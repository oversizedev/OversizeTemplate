// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___Detail.self)
public struct ___VARIABLE_categoryName___DetailView: ViewProtocol {
    public var body: some View {
        NavigationCoverLayoutView("Detail") {
            stateView(viewState.___VARIABLE_categoryVariableName___State)
        } cover: {
            cover
        } background: {
            Color.backgroundSecondary
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
    private func stateView(_ state: LoadingState<___VARIABLE_categoryName___>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_categoryName___DetailPlaceholder()
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

    private func content(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        LeadingLazyVStack {
            SectionView("Information") {
                LeadingVStack {
                    Row(
                        "Name",
                        subtitle: ___VARIABLE_categoryVariableName___.name
                    )
                }
            }
            .sectionContentCompactRowMargins()

            SectionView("Items") {
                ___VARIABLE_modelPluralVariableName___Section
            }
            .sectionContentCompactRowMargins()
        }
    }

    @ViewBuilder
    private var ___VARIABLE_modelPluralVariableName___Section: some View {
        switch viewState.___VARIABLE_modelPluralVariableName___State {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
        case let .result(___VARIABLE_modelPluralVariableName___):
            ___VARIABLE_modelName___ListContentView(
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                categories: viewState.___VARIABLE_categoryPluralVariableName___State.successResult ?? [],
                displayType: .list,
                viewOption: .standard,
                gridSize: .medium,
                onAction: { action in
                    reducer.callAsFunction(.on___VARIABLE_modelName___Action(action))
                }
            )
        case .empty:
            TextBox(
                title: "No ___VARIABLE_modelPluralVariableName___ found",
                subtitle: "This ___VARIABLE_categoryVariableName___ doesn't contain any ___VARIABLE_modelPluralVariableName___",
            )
            .textBoxSize(.small)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.large)
        case let .error(error):
            ErrorView(error: error)
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

                if let ___VARIABLE_categoryVariableName___ = viewState.___VARIABLE_categoryVariableName___State.successResult {
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