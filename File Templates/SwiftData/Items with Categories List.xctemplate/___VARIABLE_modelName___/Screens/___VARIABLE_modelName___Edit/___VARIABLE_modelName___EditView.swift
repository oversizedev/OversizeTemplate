// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Edit.self)
public struct ___VARIABLE_modelName___EditView: ViewProtocol {
    public var body: some View {
        NavigationLayout(viewState.title) {
            ___VARIABLE_modelName___EditForm(
                viewState: viewState,
                onSelectCategory: { reducer.callAsFunction(.onSelectCategory($0)) },
                onTapCreateCategory: { reducer.callAsFunction(.onTapCreateCategory) }
            )
        }
        .backConfirmationDialog(viewState.hasChanges ? .discard : nil)
        .contentMargins()
        .toolbarTitleDisplayMode(.inline)
        .toolbar { toolbarContent }
        .errorState(viewState.___VARIABLE_modelVariableName___State)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationOpen($viewState.destination)
        .navigationBack($viewState.isDismissed)
        .onChangeValue(of: viewState.form) { _ in reducer.callAsFunction(.onFormChanged) }
        .task { reducer.callAsFunction(.onAppear) }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___EditView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button {
                reducer.callAsFunction(.onTapSave)
            } label: {
                if viewState.isSaving {
                    ProgressView()
                } else {
                    Label(L10n.Button.save, systemImage: "checkmark")
                }
            }
            .labelStyle(.toolbar)
            .buttonStyle(.toolbarPrimary)
            .accessibilityLabel(L10n.Button.save)
            .disabled(!viewState.isValidForm || viewState.isSaving)
            .keyboardShortcut(.defaultAction)
        }
    }
}

#Preview("Create") {
    NavigationStack {
        ___VARIABLE_modelName___Edit.build(input: .init())
    }
}

#Preview("Edit") {
    NavigationStack {
        ___VARIABLE_modelName___Edit.build(input: .init(___VARIABLE_modelVariableName___: .init(name: "Netflix", color: .red, date: .now, note: "Family plan")))
    }
}
