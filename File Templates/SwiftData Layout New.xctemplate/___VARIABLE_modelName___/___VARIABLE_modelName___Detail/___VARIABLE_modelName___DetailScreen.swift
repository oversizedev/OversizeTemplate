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

public extension ___VARIABLE_modelName___DetailScreen {
    static func build(id: UUID) -> some View {
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___Id: id)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___DetailReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }

    static func build(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___DetailReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}

public struct ___VARIABLE_modelName___DetailScreen: View {
    // States
    @State var viewState: ___VARIABLE_modelName___DetailViewState
    let reducer: ___VARIABLE_modelName___DetailReducer

    // Initial
    public init(viewState: ___VARIABLE_modelName___DetailViewState, reducer: ___VARIABLE_modelName___DetailReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationCoverLayoutView("___VARIABLE_modelName___ Detail") {
            stateView(viewState.___VARIABLE_modelVariableName___State)
        } cover: {
            cover
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: toolbarContent)
        .alert(___VARIABLE_modelVariableName___: $viewState.alert) { $0.alert }
        .task { reducer.callAsFunction(.onAppear) }
        .refreshable(action: { reducer.callAsFunction(.onRefresh) })
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingViewState<___VARIABLE_modelName___>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_modelName___DetailPlaceholder()
        case let .result(model):
            content(model)
        case let .error(error):
            ErrorView(error)
        }
    }

    private var cover: some View {
        VStack(spacing: .medium) {
            if let image = viewState.___VARIABLE_modelVariableName___State.result?.image {
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
                    viewState.___VARIABLE_modelVariableName___State.result?.color ?? .blue,
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack(spacing: .medium) {
            // Basic Information
            VStack(alignment: .leading, spacing: .small) {
                Row(___VARIABLE_modelVariableName___.name)
                    .headline(.large)
                
                if let brand = ___VARIABLE_modelVariableName___.brand {
                    Row("Brand", subtitle: brand)
                }
                
                Row("Category", subtitle: ___VARIABLE_modelVariableName___.category)
                Row("Serving Size", subtitle: ___VARIABLE_modelVariableName___.servingSize)
                
                if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                    Row("Notes", subtitle: note)
                }
            }
            .surfaceContentMargins()
            .surface(backgroundColor: .surfaceSecondary)
            
            // Nutrition Information
            GroupBox("Nutrition Information") {
                VStack(spacing: .small) {
                    Row("Calories", trailing: {
                        Text("\(Int(___VARIABLE_modelVariableName___.calories)) kcal")
                            .subheadline(.medium)
                    })
                    
                    Divider()
                    
                    Row("Protein", trailing: {
                        Text("\(___VARIABLE_modelVariableName___.protein, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    Row("Carbohydrates", trailing: {
                        Text("\(___VARIABLE_modelVariableName___.carbs, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    Row("Fat", trailing: {
                        Text("\(___VARIABLE_modelVariableName___.fat, specifier: "%.1f")g")
                            .subheadline(.medium)
                    })
                    
                    if let fiber = ___VARIABLE_modelVariableName___.fiber, fiber > 0 {
                        Row("Fiber", trailing: {
                            Text("\(fiber, specifier: "%.1f")g")
                                .subheadline(.medium)
                        })
                    }
                    
                    if let sugar = ___VARIABLE_modelVariableName___.sugar, sugar > 0 {
                        Row("Sugar", trailing: {
                            Text("\(sugar, specifier: "%.1f")g")
                                .subheadline(.medium)
                        })
                    }
                    
                    if let sodium = ___VARIABLE_modelVariableName___.sodium, sodium > 0 {
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
            if ___VARIABLE_modelVariableName___.viewCount > 0 || ___VARIABLE_modelVariableName___.isFavorite {
                VStack(alignment: .leading, spacing: .small) {
                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Row("Favorite", trailing: {
                            Image.Base.heart.icon(.accent)
                        })
                    }
                    
                    if ___VARIABLE_modelVariableName___.viewCount > 0 {
                        Row("View Count", trailing: {
                            Text("\(___VARIABLE_modelVariableName___.viewCount)")
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
            Button(action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___) }) {
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
                Button(action: { reducer.callAsFunction(.onTapEdit___VARIABLE_modelName___) }) {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Base.edit.icon()
                    }
                }

                Button(action: { reducer.callAsFunction(.onTapDelete___VARIABLE_modelName___) }) {
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
