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

    private func content(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        LeadingVStack {
            Row(___VARIABLE_modelVariableName___.name)
            
            if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                Row("Note", subtitle: note)
            }
            
            Row("Date", subtitle: ___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
            
            Row("Color") {
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 24, height: 24)
            }
            
            HStack {
                Text("Properties")
                    .font(.headline)
                    .foregroundColor(.onSurfacePrimary)
                Spacer()
            }
            .padding(.top)
            
            LazyVStack(spacing: 0) {
                Row("Favorite", subtitle: ___VARIABLE_modelVariableName___.isFavorite ? "Yes" : "No")
                Row("Archived", subtitle: ___VARIABLE_modelVariableName___.isArchive ? "Yes" : "No")
                Row("View Count", subtitle: "\(___VARIABLE_modelVariableName___.viewCount)")
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
