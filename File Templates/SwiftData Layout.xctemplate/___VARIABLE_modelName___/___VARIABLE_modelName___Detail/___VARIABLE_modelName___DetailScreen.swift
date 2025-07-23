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

    private var cover: some View {
        if case let .result(___VARIABLE_modelVariableName___) = viewState.___VARIABLE_modelVariableName___State {
            VStack {
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: .medium) {
                        Circle()
                            .fill(___VARIABLE_modelVariableName___.color)
                            .frame(width: 60, height: 60)
                        
                        Text(___VARIABLE_modelVariableName___.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.onSurfacePrimary)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                LinearGradient(
                    colors: [
                        ___VARIABLE_modelVariableName___.color.opacity(0.3),
                        ___VARIABLE_modelVariableName___.color,
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
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

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack {
            // Header Info
            HStack {
                VStack(alignment: .leading, spacing: .xSmall) {
                    Text(___VARIABLE_modelVariableName___.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.onSurfacePrimary)
                    
                    Text(___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .omitted))
                        .font(.subheadline)
                        .foregroundStyle(Color.onSurfaceSecondary)
                }
                
                Spacer()
                
                HStack(spacing: .small) {
                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Image.Base.heart.icon(.accent, size: .medium)
                    }
                    
                    if ___VARIABLE_modelVariableName___.isArchive {
                        Image.Base.archive.icon(.onSurfaceSecondary, size: .medium)
                    }
                    
                    Circle()
                        .fill(___VARIABLE_modelVariableName___.color)
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.medium)
            
            // Note Section
            if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                VStack(alignment: .leading, spacing: .small) {
                    Text("Note")
                        .font(.headline)
                        .foregroundStyle(Color.onSurfacePrimary)
                    
                    Text(note)
                        .font(.body)
                        .foregroundStyle(Color.onSurfaceSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.medium)
                .background {
                    RoundedRectangle(cornerRadius: .medium)
                        .fill(Color.surfaceSecondary)
                }
                .padding(.horizontal, .medium)
            }
            
            // Additional Info
            LazyVStack(spacing: 0) {
                Row("Created", subtitle: ___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .shortened))
                
                Row("View Count", subtitle: "\(___VARIABLE_modelVariableName___.viewCount)")
                
                if ___VARIABLE_modelVariableName___.isArchive {
                    Row("Status", subtitle: "Archived")
                        .rowTextColor(.orange)
                }
                
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Row("Favorite", subtitle: "Yes")
                        .rowTextColor(.accent)
                }
            }
            .padding(.medium)
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
