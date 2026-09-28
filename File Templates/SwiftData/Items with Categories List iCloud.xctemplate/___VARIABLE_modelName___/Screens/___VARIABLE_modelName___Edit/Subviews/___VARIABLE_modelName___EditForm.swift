// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeMediaKit
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___EditForm: View {
    @Bindable var viewState: ___VARIABLE_modelName___EditViewState
    let onSelectCategory: (___VARIABLE_categoryName___?) -> Void
    let onTapCreateCategory: () -> Void

    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewState.FocusField?

    var body: some View {
        VStack(spacing: .small) {
            nameField

            noteField

            categoryField

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

    private var nameField: some View {
        TextField("Name", text: $viewState.form.name)
            .textFieldStyle(.placeholder("Name", text: $viewState.form.name))
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
            .focused($focusedField, equals: .name)
    }

    private var noteField: some View {
        TextEditor(text: $viewState.form.note)
            .focused($focusedField, equals: .note)
            .textEditorPlaceholder("Note", text: $viewState.form.note)
    }

    private var categoryField: some View {
        Select(
            "Category",
            viewState.___VARIABLE_categoryVariableName___Options,
            selection: Binding(
                get: { viewState.selected___VARIABLE_categoryName___ },
                set: onSelectCategory
            ),
            activeModal: $viewState.isShow___VARIABLE_categoryName___Picker
        ) { ___VARIABLE_categoryVariableName___, _ in
            Row(___VARIABLE_categoryVariableName___?.name ?? "No Category")
        } selectionView: { ___VARIABLE_categoryVariableName___ in
            Text(___VARIABLE_categoryVariableName___?.name ?? "No Category")
        } actions: {
            Button("Add", action: onTapCreateCategory)
        }
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
    ___VARIABLE_modelName___EditForm(
        viewState: .init(input: .init()),
        onSelectCategory: { _ in },
        onTapCreateCategory: {}
    )
    .padding()
}
