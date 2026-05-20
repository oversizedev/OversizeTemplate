// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Detail.self)
public struct ___VARIABLE_modelName___DetailScreen: ViewProtocol {
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
        .task { await viewModel.onAppear() }
        .refreshable { await viewModel.onRefresh() }
        .navigationMove($viewState.destination)
        .navigationBack($viewState.isDismissed)
    }

    @ViewBuilder
    private func stateView(_ state: LoadingState<___VARIABLE_modelName___>) -> some View {
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
            Row(___VARIABLE_modelVariableName___.name ?? "Untitled")

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
            Button(action: { Task { await viewModel.delete___VARIABLE_modelName___() } }) {
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
                Button(action: { Task { await viewModel.onEdit() } }) {
                    Label {
                        Text(L10n.Button.edit)
                    } icon: {
                        Image.Base.edit.icon()
                    }
                }

                Button(action: { Task { await viewModel.delete___VARIABLE_modelName___() } }) {
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

#Preview {
    NavigationStack {
        ___VARIABLE_modelName___Detail.build()
    }
}
