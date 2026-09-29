// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeMediaKit
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___EditForm: View {
    @Bindable var viewState: ___VARIABLE_categoryName___EditViewState

    @FocusState private var focusedField: ___VARIABLE_categoryName___EditViewState.FocusField?

    var body: some View {
        VStack(spacing: .small) {
            emojiField

            nameField

            noteField

            #if !os(tvOS)
                colorField
            #endif

            #if os(iOS)
                dateField

                imageField
            #endif
        }
        .fieldLabelPosition(.overInput)
        .controlRadius(.large)
        .onAppear { focusedField = .name }
    }

    private var emojiField: some View {
        EmojiField(
            "Icon",
            emojis: viewState.emojis,
            selection: $viewState.form.emoji
        )
        .iconPickerStyle(.circle)
    }

    private var nameField: some View {
        VStack(alignment: .leading, spacing: .xxxSmall) {
            TextField("Name", text: $viewState.form.name)
                .textFieldStyle(.placeholder("Name", text: $viewState.form.name))
                .submitLabel(.continue)
                .onSubmit { focusedField = .note }
                .focused($focusedField, equals: .name)

            if viewState.isDuplicateName {
                Text("A category with this name already exists")
                    .font(.caption)
                    .foregroundStyle(Color.error)
            }
        }
    }

    private var noteField: some View {
        TextEditor(text: $viewState.form.note)
            .focused($focusedField, equals: .note)
            .textEditorPlaceholder("Note", text: $viewState.form.note)
    }

    private var colorField: some View {
        Row("Color", trailing: {
            ColorPicker("", selection: $viewState.form.color)
                .labelsHidden()
        })
        .rowOnSurface(backgroundColor: Color.surfaceSecondary)
        .surfaceContentMargins(.init(horizontal: .small, vertical: .small))
    }

    #if os(iOS)
        private var dateField: some View {
            DateField(selection: $viewState.form.date)
        }

        private var imageField: some View {
            PhotoField($viewState.form.image)
        }
    #endif
}

#Preview {
    ___VARIABLE_categoryName___EditForm(viewState: .init(input: .init()))
        .padding()
}
