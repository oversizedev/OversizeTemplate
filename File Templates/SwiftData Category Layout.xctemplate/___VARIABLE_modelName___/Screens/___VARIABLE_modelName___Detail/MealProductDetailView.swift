//
// Copyright © 2025 Alexander Romanov
// MealProductDetailView.swift, created on 10.07.2025
//

import Database
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: MealProductDetail.self)
public struct MealProductDetailView: ViewProtocol {
    public var body: some View {
        NavigationCoverLayoutView(viewState.mealProductState.successResult?.name ?? "") {
            stateView(viewState.mealProductState)
        } cover: {
            cover
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
    private func stateView(_ state: LoadingState<MealProduct>) -> some View {
        switch state {
        case .idle, .loading:
            MealProductDetailPlaceholder()
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

    private func content(_ mealProduct: MealProduct) -> some View {
        LeadingVStack {
            Row(mealProduct.name)
        }
    }
}

// MARK: - Toolbar

private extension MealProductDetailView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: {
                reducer.callAsFunction(.onTapDeleteMealProduct)
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
                Button(action: { reducer.callAsFunction(.onTapEditMealProduct) }) {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Design.PencilAndSquare.mini
                    }
                }

                if let mealProduct = viewState.mealProductState.successResult {
                    Menu {
                        Button(action: { reducer.callAsFunction(.onTapSelectCategory(nil)) }) {
                            Label {
                                Text("No Category")
                            } icon: {
                                if mealProduct.categoryId == nil {
                                    Image.Base.Check.mini
                                }
                            }
                        }

                        ForEach(viewState.categoriesState.successResult ?? []) { category in
                            Button(action: { reducer.callAsFunction(.onTapSelectCategory(category)) }) {
                                Label {
                                    Text(category.name)
                                } icon: {
                                    if mealProduct.categoryId == category.id {
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
                            Text(mealProduct.isFavorite ? "Unfavorite" : "Favorite")
                        } icon: {
                            if mealProduct.isFavorite {
                                Image.Base.Unstar.mini
                            } else {
                                Image.Base.Star.mini
                            }
                        }
                    }
                }

                Button(role: .destructive, action: { reducer.callAsFunction(.onTapDeleteMealProduct) }) {
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
