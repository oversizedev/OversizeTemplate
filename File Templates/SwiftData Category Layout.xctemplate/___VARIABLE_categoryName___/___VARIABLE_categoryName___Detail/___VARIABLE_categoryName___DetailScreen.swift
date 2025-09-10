// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___DetailScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_categoryName___DetailViewState
    let reducer: Reducer<___VARIABLE_categoryName___DetailViewModel>

    // Initial
    @MainActor
    public init(viewState: ___VARIABLE_categoryName___DetailViewState, reducer: Reducer<___VARIABLE_categoryName___DetailViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(title) {
            stateView(viewState.___VARIABLE_categoryVariableName___State)
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: { toolbarContent })
        .toolbarTitleDisplayMode(.inline)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .task(priority: .background) {
            reducer.callAsFunction(.onAppear)
        }
        .refreshable(action: {
            reducer.callAsFunction(.onRefresh)
        })
        .navigationMove($viewState.destination)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_categoryName___>) -> some View {
        switch state {
        case .idle, .loading:
            ___VARIABLE_categoryName___DetailPlaceholder()
        case let .result(___VARIABLE_categoryVariableName___):
            content(___VARIABLE_categoryVariableName___)
        case let .error(error):
            ErrorView(error: error)
        }
    }

    @ViewBuilder
    private func content(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        LazyVStack(alignment: .leading, spacing: .large) {
            headerSection(___VARIABLE_categoryVariableName___)
            
            if let note = ___VARIABLE_categoryVariableName___.note, !note.isEmpty {
                noteSection(note)
            }
            
            detailsSection(___VARIABLE_categoryVariableName___)
        }
        .paddingContent()
    }

    @ViewBuilder
    private func headerSection(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack(spacing: .medium) {
                Circle()
                    .fill(___VARIABLE_categoryVariableName___.color)
                    .frame(width: 60, height: 60)
                    .overlay {
                        if ___VARIABLE_categoryVariableName___.isFavorite {
                            Image.Base.Star.mini
                                .foregroundColor(.onSurfaceHighEmphasis)
                        }
                    }

                VStack(alignment: .leading, spacing: .xxSmall) {
                    Text(___VARIABLE_categoryVariableName___.name)
                        .headline(.medium)
                        .foregroundColor(.onSurfaceHighEmphasis)

                    Text("Created \(___VARIABLE_categoryVariableName___.date, style: .date)")
                        .body(.medium)
                        .foregroundColor(.onSurfaceDisabled)
                }

                Spacer()
            }
        }
    }

    @ViewBuilder
    private func noteSection(_ note: String) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Note")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            Text(note)
                .body(.medium)
                .foregroundColor(.onSurfaceMediumEmphasis)
        }
    }

    @ViewBuilder
    private func detailsSection(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Details")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            VStack(spacing: .zero) {
                Row("View Count", trailing: { Text("\(___VARIABLE_categoryVariableName___.viewCount)") })
                Row("Favorite", trailing: { Text(___VARIABLE_categoryVariableName___.isFavorite ? "Yes" : "No") })
                Row("Created", trailing: { Text(___VARIABLE_categoryVariableName___.date, style: .date) })
            }
        }
    }

    private var title: String {
        if case let .result(___VARIABLE_categoryVariableName___) = viewState.___VARIABLE_categoryVariableName___State {
            return ___VARIABLE_categoryVariableName___.name
        }
        return "___VARIABLE_categoryName___"
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___DetailScreen {
    @ViewBuilder
    private func editButton() -> some View {
        Button {
            reducer.callAsFunction(.onTapEdit)
        } label: {
            Text("Edit")
        }
    }

    @ViewBuilder
    private func moreButton() -> some View {
        Menu {
            Button(action: { reducer.callAsFunction(.onToggleFavorite) }) {
                Label {
                    if case let .result(___VARIABLE_categoryVariableName___) = viewState.___VARIABLE_categoryVariableName___State {
                        Text(___VARIABLE_categoryVariableName___.isFavorite ? "Unfavorite" : "Favorite")
                    } else {
                        Text("Favorite")
                    }
                } icon: {
                    if case let .result(___VARIABLE_categoryVariableName___) = viewState.___VARIABLE_categoryVariableName___State,
                       ___VARIABLE_categoryVariableName___.isFavorite {
                        Image.Base.Unstar.mini
                    } else {
                        Image.Base.Star.mini
                    }
                }
            }

            Button(action: { reducer.callAsFunction(.onTapDuplicate) }) {
                Label {
                    Text("Duplicate")
                } icon: {
                    Image.Documentation.Copy.mini
                }
            }

            Button(role: .destructive, action: { reducer.callAsFunction(.onTapDelete) }) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Editor.TrashWithLines.mini
                }
            }
        } label: {
            Image.Base.more.icon()
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            editButton()
            moreButton()
        }
    }
}

public extension ___VARIABLE_categoryName___DetailScreen {
    @MainActor
    static func build(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        logNotice("Building ___VARIABLE_categoryName___DetailScreen for \(___VARIABLE_categoryVariableName___.name)")
        let viewState = ___VARIABLE_categoryName___DetailViewState(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        let viewModel = ___VARIABLE_categoryName___DetailViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_categoryName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview {
    NavigationStack {
        ___VARIABLE_categoryName___DetailScreen.build(
            ___VARIABLE_categoryVariableName___: .init(
                name: "Sample ___VARIABLE_categoryName___",
                emoji: "📁",
                color: .blue,
                date: Date(),
                note: "This is a sample note for the ___VARIABLE_categoryVariableName___.",
                isFavorite: true,
                viewCount: 15,
                index: 0
            )
        )
    }
}