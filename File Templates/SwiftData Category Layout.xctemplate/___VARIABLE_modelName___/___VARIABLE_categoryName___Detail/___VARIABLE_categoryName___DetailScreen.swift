//___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
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
        NavigationCoverLayoutView("Detail") {
            stateView(viewState.___VARIABLE_categoryVariableName___State)
        } cover: {
            cover
        } background: {
            Color.backgroundPrimary
        }
        .toolbar { toolbarContent }
        .presentationAlert($viewState.alert)
        .presentationHUD($viewState.hud)
        .task {
            reducer.callAsFunction(.onAppear)
        }
        .refreshable(action: {
            reducer.callAsFunction(.onRefresh)
        })
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
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

    private var cover: some View {
        VStack {
            if let emoji = viewState.___VARIABLE_categoryVariableName___State.value?.emoji {
                Text(emoji)
                    .font(.system(size: 60))
            } else {
                Image.Objects.Folder.icon(.extraLarge)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(
                colors: [
                    Color.surfacePrimary,
                    viewState.___VARIABLE_categoryVariableName___State.value?.color ?? .blue,
                ],
                startPoint: .top,
                endPoint: .bottom,
            )
        }
    }

    private func content(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        LeadingVStack {
            VStack(spacing: .medium) {
                Row("Name") {
                    Text(___VARIABLE_categoryVariableName___.name)
                        .headline(.medium)
                }
                
                if let note = ___VARIABLE_categoryVariableName___.note, !note.isEmpty {
                    Row("Note") {
                        Text(note)
                            .body(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Row("Items") {
                    Text("\(___VARIABLE_categoryVariableName___.___VARIABLE_modelVariableName___Count) ___VARIABLE_modelPluralVariableName___")
                        .headline(.medium)
                }
                
                Row("Color") {
                    HStack {
                        Circle()
                            .fill(___VARIABLE_categoryVariableName___.color)
                            .frame(width: 24, height: 24)
                        Text("Custom Color")
                            .body(.medium)
                    }
                }
                
                Row("Created") {
                    Text(___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                        .body(.medium)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .paddingContent()
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___DetailScreen {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                reducer.callAsFunction(.onTapEdit)
            } label: {
                Text(L10n.Button.edit)
            }
        }
    }
}

public extension ___VARIABLE_categoryName___DetailScreen {
    @MainActor
    static func build(___VARIABLE_categoryVariableName___Id: UUID) -> some View {
        logNotice("Building ___VARIABLE_categoryName___DetailScreen")
        let viewState = ___VARIABLE_categoryName___DetailViewState(___VARIABLE_categoryVariableName___Id: ___VARIABLE_categoryVariableName___Id)
        let viewModel = ___VARIABLE_categoryName___DetailViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_categoryName___DetailScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview {
    NavigationStack {
        ___VARIABLE_categoryName___DetailScreen.build(___VARIABLE_categoryVariableName___Id: UUID())
    }
}