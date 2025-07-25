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
        let reducer = Reducer(viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }

    static func build(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        let viewState = ___VARIABLE_modelName___DetailViewState(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        let viewModel = ___VARIABLE_modelName___DetailViewModel(state: viewState)
        let reducer = Reducer(viewModel)
        return ___VARIABLE_modelName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}

public struct ___VARIABLE_modelName___DetailScreen: View {
    // States
    @State var viewState: ___VARIABLE_modelName___DetailViewState
    let reducer: Reducer<___VARIABLE_modelName___DetailViewModel>

    // Initial
    public init(viewState: ___VARIABLE_modelName___DetailViewState, reducer: Reducer<___VARIABLE_modelName___DetailViewModel>) {
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
        .task { reducer(.onAppear) }
        .refreshable(action: { reducer(.onRefresh) })
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
        VStack {
            if case let .result(___VARIABLE_modelVariableName___) = viewState.___VARIABLE_modelVariableName___State {
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack(spacing: .medium) {
                        RoundedRectangle(cornerRadius: .large)
                            .fill(___VARIABLE_modelVariableName___.color)
                            .frame(width: 80, height: 80)
                        
                        Text(___VARIABLE_modelVariableName___.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            } else {
                Text("___VARIABLE_modelName___ Cover")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            if case let .result(___VARIABLE_modelVariableName___) = viewState.___VARIABLE_modelVariableName___State {
                LinearGradient(
                    colors: [
                        ___VARIABLE_modelVariableName___.color.opacity(0.8),
                        ___VARIABLE_modelVariableName___.color,
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
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
            // Basic Info Section
            Surface {
                VStack(alignment: .leading, spacing: .medium) {
                    Row("Name") {
                        HStack {
                            RoundedRectangle(cornerRadius: .xxSmall)
                                .fill(___VARIABLE_modelVariableName___.color)
                                .frame(width: 16, height: 16)
                            Text(___VARIABLE_modelVariableName___.name)
                        }
                    }
                    
                    Row("Date") {
                        Text(___VARIABLE_modelVariableName___.date.formatted(date: .complete, time: .shortened))
                    }
                    
                    if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                        Row("Notes") {
                            Text(note)
                                .foregroundColor(.onSurfaceSecondary)
                        }
                    }
                }
            }
            
            // Status Section
            Surface {
                VStack(alignment: .leading, spacing: .medium) {
                    Row("Status") {
                        HStack(spacing: .medium) {
                            HStack(spacing: .xSmall) {
                                Image.Base.heart
                                    .icon(___VARIABLE_modelVariableName___.isFavorite ? .accent : .onSurfaceTertiary)
                                Text("Favorite")
                                    .foregroundColor(___VARIABLE_modelVariableName___.isFavorite ? .accent : .onSurfaceTertiary)
                            }
                            
                            HStack(spacing: .xSmall) {
                                Image.Base.archive
                                    .icon(___VARIABLE_modelVariableName___.isArchive ? .warning : .onSurfaceTertiary)
                                Text("Archived")
                                    .foregroundColor(___VARIABLE_modelVariableName___.isArchive ? .warning : .onSurfaceTertiary)
                            }
                        }
                    }
                    
                    Row("View Count") {
                        HStack(spacing: .xSmall) {
                            Image.Base.eye
                                .icon(.onSurfaceSecondary)
                            Text("\(___VARIABLE_modelVariableName___.viewCount)")
                        }
                    }
                }
            }
        }
    }

    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        #if os(macOS)
        ToolbarItemGroup(placement: .primaryAction) {
            Button(action: { reducer(.onTapEdit___VARIABLE_modelName___) }) {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Image.Base.edit.icon(.onSurfaceSecondary)
                }
            }
            
            Button(action: { reducer(.onTapDelete___VARIABLE_modelName___) }) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.trashWithLines.icon(
                        .error,
                        size: .medium
                    )
                }
            }
        }
        #else
        ToolbarItem(placement: .confirmationAction) {
            Menu {
                Button(action: { reducer(.onTapEdit___VARIABLE_modelName___) }) {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Base.edit.icon()
                    }
                }

                Button(action: { reducer(.onTapDelete___VARIABLE_modelName___) }) {
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
