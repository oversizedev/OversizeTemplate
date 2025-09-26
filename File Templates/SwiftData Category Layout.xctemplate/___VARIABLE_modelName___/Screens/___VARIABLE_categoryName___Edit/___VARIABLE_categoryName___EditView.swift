// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeNavigation
import OversizePhotoComponents
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_categoryName___Edit.self)
public struct ___VARIABLE_categoryName___EditView: ViewProtocol {
    @FocusState private var focusedField: ___VARIABLE_categoryName___EditViewState.FocusField?

    public var body: some View {
        NavigationLayoutView(
            viewState.title,
            content: content
        ) {
            Color.backgroundPrimary
        }
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: { toolbarContent })
        .navigationDismiss(trigger: $viewState.isDismissed)
        .presentationHUD($viewState.hud)
        .onChangeValue(of: viewState.focusedField) { focusedField = $0 }
        .task { reducer.callAsFunction(.onAppear) }
        .onAppear { focusedField = .name }
    }

    @ViewBuilder
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
        .paddingContent()
    }
}

// MARK: - Fields

private extension ___VARIABLE_categoryName___EditView {
    private var titleField: some View {
        TextField("Name", text: $viewState.name)
            .textFieldStyle(.placeholder("Name", text: $viewState.name))
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
            .focused($focusedField, equals: .name)
            .onChangeValue(of: viewState.name) { reducer.callAsFunction(.onNameChanged($0)) }
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
                    set: { _ in },
                ),
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
        PhotoFieldView($viewState.image)
    }
    #endif

    private var emojiField: some View {
        EmojiPicker("Icon", emojis: viewState.emojis, selection: $viewState.emoji)
            .iconPickerStyle(.circle)
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___EditView {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(L10n.Button.save, systemImage: "checkmark") {
                reducer.callAsFunction(.onTapSave)
            }
            .labelStyle(.toolbar)
            .buttonStyle(.toolbarPrimary)
            .disabled(!viewState.isValidForm)
            .keyboardShortcut(.defaultAction)
        }
    }
}