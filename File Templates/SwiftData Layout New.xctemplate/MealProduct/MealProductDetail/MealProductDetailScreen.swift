 // ___FILEHEADER___

import Database
import Environment
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeNavigation
import OversizeUI
import SwiftUI

public extension MealProductDetailScreen {
    static func build(id: UUID) -> some View {
        let viewState = MealProductDetailViewState(mealProductId: id)
        let viewModel = MealProductDetailViewModel(state: viewState)
        let reducer = MealProductDetailReducer(viewModel: viewModel)
        return MealProductDetailScreen(viewState: viewState, reducer: reducer)
    }

    static func build(mealProduct: MealProduct) -> some View {
        let viewState = MealProductDetailViewState(mealProduct: mealProduct)
        let viewModel = MealProductDetailViewModel(state: viewState)
        let reducer = MealProductDetailReducer(viewModel: viewModel)
        return MealProductDetailScreen(viewState: viewState, reducer: reducer)
    }
}

public struct MealProductDetailScreen: View {
    // States
    @State var viewState: MealProductDetailViewState
    let reducer: MealProductDetailReducer

    // Initial
    public init(viewState: MealProductDetailViewState, reducer: MealProductDetailReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationCoverLayoutView("MealProduct Detail") {
            stateView(viewState.mealProductState)
        } cover: {
            cover
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: toolbarContent)
        .alert(item: $viewState.alert) { $0.alert }
        .task { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<MealProduct>) -> some View {
        switch state {
        case .idle, .loading:
            MealProductDetailPlaceholder()
        case let .result(model):
            content(model)
        case let .error(error):
            ErrorView(error)
        }
    }

    private var cover: some View {
        VStack(spacing: .medium) {
            if let image = viewState.mealProductState.result?.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            } else {
                VStack {
                    Image.Base.photo.icon(.large)
                        .foregroundColor(.onSurfaceSecondary)
                    
                    Text("No Image")
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                .frame(height: 200)
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            LinearGradient(
                colors: [
                    Color.surfacePrimary,
                    viewState.mealProductState.result?.color ?? .blue,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func content(_ mealProduct: MealProduct) -> some View {
        LeadingVStack(spacing: .medium) {
            // Basic Information
            VStack(alignment: .leading, spacing: .small) {
                Row(mealProduct.name)
                    .headline(.large)
                
                if let brand = mealProduct.brand {
                    Row("Brand", subtitle: brand)
                }
                
                Row("Category", subtitle: mealProduct.category)
                Row("Serving Size", subtitle: mealProduct.servingSize)
                
                if let note = mealProduct.note, !note.isEmpty {
                    Row("Notes", subtitle: note)
                }
            }
            .surfaceContentMargins()
            .surface(backgroundColor: .surfaceSecondary)
            
            // Nutrition Information
            GroupBox("Nutrition Information") {
                VStack(spacing: .small) {
                    Row("Calories", trailing: {
                        Text("\(Int(mealProduct.calories)) kcal")
                            .subheadline(.medium)
                    })
                    
                    Divider()
                    
                    Row("Protein", trailing: {
                        Text("\(mealProduct.protein, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    Row("Carbohydrates", trailing: {
                        Text("\(mealProduct.carbs, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    Row("Fat", trailing: {
                        Text("\(mealProduct.fat, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    if let fiber = mealProduct.fiber, fiber > 0 {
                        Row("Fiber", trailing: {
                            Text("\(fiber, specifier: "%.1f")g")
                                .subheadline(.medium)
                        })
                    }
                    
                    if let sugar = mealProduct.sugar, sugar > 0 {
                        Row("Sugar", trailing: {
                            Text("\(sugar, specifier: "%.1f")g")
                                .subheadline(.medium)
                        })
                    }
                    
                    if let sodium = mealProduct.sodium, sodium > 0 {
                        Row("Sodium", trailing: {
                            Text("\(sodium, specifier: "%.1f")mg")
                                .subheadline(.medium)
                        })
                    }
                }
            }
            .surfaceContentMargins()
            .surface(backgroundColor: .surfaceSecondary)
            
            // Additional Information
            if mealProduct.viewCount > 0 || mealProduct.isFavorite {
                VStack(alignment: .leading, spacing: .small) {
                    if mealProduct.isFavorite {
                        Row("Favorite", trailing: {
                            Image.Base.heart.icon(.accent)
                        })
                    }
                    
                    if mealProduct.viewCount > 0 {
                        Row("View Count", trailing: {
                            Text("\(mealProduct.viewCount)")
                                .subheadline(.medium)
                        })
                    }
                }
                .surfaceContentMargins()
                .surface(backgroundColor: .surfaceSecondary)
            }
        }
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: { reducer.callAsFunction(.onTapDeleteMealProduct) }) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.trashWithLines.icon(
                        .onSurfaceSecondary,
                        size: .medium
                    )
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
                        Image.Base.edit.icon()
                    }
                }

                Button(action: { reducer.callAsFunction(.onTapDeleteMealProduct) }) {
                    Label {
                        Text(L10n.Button.delete)
                    } icon: {
                        Image.Base.delete.icon(Color.error)
                    }
                }

            } label: {
                Image.Base.more.icon()
            }
        }
        #endif
    }
}
