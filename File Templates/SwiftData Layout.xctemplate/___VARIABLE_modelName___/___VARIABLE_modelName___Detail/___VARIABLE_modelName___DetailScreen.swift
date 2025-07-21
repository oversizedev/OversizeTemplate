 // ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
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
        .alert(item: $viewState.alert) { $0.alert }
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

    @ViewBuilder
    private var cover: some View {
        VStack {
            if case let .result(___VARIABLE_modelVariableName___) = viewState.___VARIABLE_modelVariableName___State {
                if let imageData = ___VARIABLE_modelVariableName___.imageData,
                   let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                } else {
                    VStack(spacing: .medium) {
                        Circle()
                            .fill(___VARIABLE_modelVariableName___.color)
                            .frame(width: 80, height: 80)
                        
                        Text(___VARIABLE_modelVariableName___.name)
                            .title(.semibold)
                            .foregroundColor(.onPrimary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        LinearGradient(
                            colors: [
                                ___VARIABLE_modelVariableName___.color.opacity(0.8),
                                ___VARIABLE_modelVariableName___.color,
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                }
            } else {
                VStack {
                    Text("___VARIABLE_modelName___ Cover")
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
        }
    }

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack {
            // Header Section
            VStack(alignment: .leading, spacing: .medium) {
                HStack {
                    Circle()
                        .fill(___VARIABLE_modelVariableName___.color)
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: .xxxSmall) {
                        Text(___VARIABLE_modelVariableName___.name)
                            .title2(.semibold)
                            .foregroundColor(.onSurfacePrimary)
                        
                        Text(___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .shortened))
                            .footnote()
                            .foregroundColor(.onSurfaceSecondary)
                    }
                    
                    Spacer()
                    
                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Image.Base.star.icon(.accent, size: .medium)
                    }
                }
                
                if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                    Text(note)
                        .body(.medium)
                        .foregroundColor(.onSurfacePrimary)
                        .padding(.vertical, .small)
                        .padding(.horizontal, .medium)
                        .background {
                            RoundedRectangle(cornerRadius: .small)
                                .fill(Color.surfaceSecondary)
                        }
                }
            }
            .padding(.medium)
            
            // Properties Section
            VStack(spacing: 0) {
                Row("Created") {
                    Text(___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .complete))
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                
                Row("View Count") {
                    Text("\(___VARIABLE_modelVariableName___.viewCount)")
                        .caption(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                
                Row("Status") {
                    HStack(spacing: .small) {
                        if ___VARIABLE_modelVariableName___.isFavorite {
                            Label {
                                Text("Favorite")
                            } icon: {
                                Image.Base.star.icon(.accent, size: .small)
                            }
                            .caption(.medium)
                            .foregroundColor(.accent)
                        }
                        
                        if ___VARIABLE_modelVariableName___.isArchive {
                            Label {
                                Text("Archived")
                            } icon: {
                                Image.Base.archive.icon(.onSurfaceSecondary, size: .small)
                            }
                            .caption(.medium)
                            .foregroundColor(.onSurfaceSecondary)
                        }
                        
                        if !___VARIABLE_modelVariableName___.isFavorite && !___VARIABLE_modelVariableName___.isArchive {
                            Text("Active")
                                .caption(.medium)
                                .foregroundColor(.accent)
                        }
                    }
                }
                
                if let imageData = ___VARIABLE_modelVariableName___.imageData {
                    Row("Image") {
                        if let image = ___VARIABLE_modelVariableName___.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 200, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: .small))
                        }
                    }
                }
            }
            .background(Color.surfaceSecondary)
            .clipShape(RoundedRectangle(cornerRadius: .medium))
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
