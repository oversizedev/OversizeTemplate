// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizePhotoComponents
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Edit.self)
public struct ___VARIABLE_modelName___EditScreen: ViewProtocol {
    @Environment(\.platform) private var platform
    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewState.FocusField?

    public var body: some View {
        NavigationLayoutView(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: toolbarContent)
        .task { await viewModel.onAppear() }
        .onChange(of: viewState.focusedField) { focusedField = $1 }
    }

    @ViewBuilder
    private func content() -> some View {
        VStack(spacing: .small) {
            titleField

            noteField

            #if !os(tvOS)
            urlField

            colorField
            #endif

            #if os(iOS)
            dateField

            imageField
            #endif
        }
        .fieldLabelPosition(.overInput)
        .controlRadius(.large)
        .paddingContent()
    }
}

// MARK: - Fields

private extension ___VARIABLE_modelName___EditScreen {
    private var titleField: some View {
        TextField("Name", text: $viewState.name)
            .textFieldStyle(.placeholder("Name", text: $viewState.name))
            .focused($focusedField, equals: .name)
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
    }

    private var noteField: some View {
        TextEditor(text: $viewState.note)
            .focused($focusedField, equals: .note)
            .submitLabel(.continue)
            .onSubmit { focusedField = .url }
            .textEditorPlaceholder("Note", text: $viewState.note)
    }

    private var urlField: some View {
        URLField(url: $viewState.url)
            .textFieldStyle(.placeholder(
                "URL",
                text: Binding(
                    get: { viewState.url?.absoluteString ?? "" },
                    set: { _ in }
                )
            ))
            .focused($focusedField, equals: .url)
            .submitLabel(.done)
            .onSubmit { focusedField = nil }
    }

    #if os(iOS)
    private var dateField: some View {
        DateField(selection: $viewState.date)
    }
    #endif

    private var colorField: some View {
        Row("Color", trailing: {
            ColorPicker("", selection: $viewState.color)
                .labelsHidden()
        })
        .rowOnSurface(backgroundColor: Color.surfaceSecondary)
        .surfaceContentMargins(.init(horizontal: .small, vertical: .small))
    }

    #if os(iOS)
    private var imageField: some View {
        PhotoFieldView($viewState.image)
    }
    #endif
}

// MARK: - Toolbar

private extension ___VARIABLE_modelName___EditScreen {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(action: { Task { await viewModel.onSave() } }) {
                Text(L10n.Button.save)
            }
            .disabled(!viewState.isValidForm)
            #if !os(tvOS)
            .keyboardShortcut(.defaultAction)
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        ___VARIABLE_modelName___Edit.build()
    }
}
