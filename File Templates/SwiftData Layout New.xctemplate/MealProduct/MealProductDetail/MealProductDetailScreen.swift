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
        VStack {
            Text("MealProduct Cover")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [
                    Color.surfacePrimary,
                    Color.blue,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func content(_ mealProduct: MealProduct) -> some View {
        LeadingVStack {
            Row(mealProduct.name ?? "Untitled")
            
            // Add more content based on your model properties
            LazyVStack(spacing: 0) {
                ForEach(1 ... 10, id: \.self) { item in
                    Button {} label: {
                        VStack(spacing: 0) {
                            Text("Item \(item)")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Divider()
                        }
                        .clipShape(Rectangle())
                    }
                }
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
