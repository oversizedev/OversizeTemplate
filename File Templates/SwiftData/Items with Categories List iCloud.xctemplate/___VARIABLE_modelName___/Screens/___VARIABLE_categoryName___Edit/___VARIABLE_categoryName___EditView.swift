// ___FILEHEADER___

import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeMediaKit
import OversizeNavigation
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___Edit.self)
public struct ___VARIABLE_categoryName___EditView: ViewProtocol {
    @FocusState private var focusedField: ___VARIABLE_categoryName___EditViewState.FocusField?

    public var body: some View {
        NavigationLayout(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .contentMargins()
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: { toolbarContent })
        .navigationDismiss(trigger: $viewState.isDismissed)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .onChangeValue(of: viewState.focusedField) { focusedField = $0 }
        .task { reducer.callAsFunction(.onAppear) }
        .onAppear { focusedField = .name }
    }

    private func content() -> some View {
        VStack(spacing: .small) {
            emojiField

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
    }
}

// MARK: - Fields

private extension ___VARIABLE_categoryName___EditView {
    private var titleField: some View {
        VStack(alignment: .leading, spacing: .xxxSmall) {
            TextField("Name", text: $viewState.name)
                .textFieldStyle(.placeholder("Name", text: $viewState.name))
                .submitLabel(.continue)
                .onSubmit { focusedField = .note }
                .focused($focusedField, equals: .name)
                .onChangeValue(of: viewState.name) { reducer.callAsFunction(.onNameChanged($0)) }

            if viewState.isDuplicateName {
                Text("A category with this name already exists")
                    .font(.caption)
                    .foregroundStyle(Color.error)
            }
        }
    }

    private var noteField: some View {
        TextEditor(text: $viewState.note)
            .focused($focusedField, equals: .note)
            .submitLabel(.continue)
            .onSubmit { focusedField = .url }
            .textEditorPlaceholder("Note", text: $viewState.note)
            .fieldLabelPosition(.overInput)
            .onChangeValue(of: viewState.note) { reducer.callAsFunction(.onNoteChanged($0)) }
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
            .onChangeValue(of: viewState.url) { reducer.callAsFunction(.onUrlChanged($0)) }
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
            PhotoField($viewState.image)
        }
    #endif

    private var emojiField: some View {
        EmojiField(
            "Icon",
            emojis: viewState.emojis,
            selection: $viewState.emoji
        )
        .iconPickerStyle(.circle)
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
