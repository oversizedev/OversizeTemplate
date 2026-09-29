// ___FILEHEADER___

import Models
import OversizeArchitecture
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___Edit.self)
public struct ___VARIABLE_categoryName___EditView: ViewProtocol {
    public var body: some View {
        NavigationLayout(viewState.title) {
            ___VARIABLE_categoryName___EditForm(viewState: viewState)
        }
        .backConfirmationDialog(viewState.hasChanges ? .discard : nil)
        .contentMargins()
        .toolbarTitleDisplayMode(.inline)
        .toolbar { toolbarContent }
        .errorState(viewState.___VARIABLE_categoryVariableName___State)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationBack($viewState.isDismissed)
        .onChangeValue(of: viewState.form) { _ in reducer.callAsFunction(.onFormChanged) }
        .task { reducer.callAsFunction(.onAppear) }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___EditView {
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
        ___VARIABLE_categoryName___Edit.build(input: .init())
    }
}

#Preview("Edit") {
    NavigationStack {
        ___VARIABLE_categoryName___Edit.build(input: .init(___VARIABLE_categoryVariableName___: .init(name: "Video", emoji: "🎬", color: .red, date: .now)))
    }
}
