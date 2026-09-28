// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeComponents
import OversizeCore
import OversizeLocalizable
import OversizeMediaKit
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftUI

@View(module: ___VARIABLE_modelName___Edit.self)
public struct ___VARIABLE_modelName___EditView: ViewProtocol {
    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewState.FocusField?

    public var body: some View {
        NavigationLayout(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .contentMargins()
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: { toolbarContent })
        .onChangeValue(of: viewState.focusedField) { focusedField = $0 }
        .task { reducer.callAsFunction(.onAppear) }
        .onAppear { focusedField = .name }
        .navigationOpen($viewState.destination)
        .navigationDismiss(trigger: $viewState.isDismissed)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
    }

    private func content() -> some View {
        VStack(spacing: .small) {
            titleField

            noteField

            ___VARIABLE_categoryVariableName___Field

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

private extension ___VARIABLE_modelName___EditView {
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

    private var ___VARIABLE_categoryVariableName___Field: some View {
        Select(
            "Select category",
            viewState.___VARIABLE_categoryPluralVariableName___State.result ?? [],
            selection: Binding<___VARIABLE_categoryName___?>(
                get: { viewState.selected___VARIABLE_categoryName___ },
                set: { reducer.callAsFunction(.on___VARIABLE_categoryName___Selected($0)) }
            ),
            activeModal: $viewState.isShow___VARIABLE_categoryName___Picker
        ) { ___VARIABLE_categoryVariableName___, _ in
            Row(___VARIABLE_categoryVariableName___?.name ?? "Select ___VARIABLE_categoryVariableName___")
        } selectionView: { selected in
            Text(selected?.name ?? "Select category")
        } actions: {
            Button("Add") {
                reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___)
            }
        } contentUnavailable: {
            EmptyStateView(
                title: "No categories available",
                subtitle: "Add a new category"
            ) {
                Button("Add category") {
                    reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___)
                }
            }
        }
    }

    private var create___VARIABLE_categoryName___Button: some View {
        Button(action: {
            reducer.callAsFunction(.onTapCreate___VARIABLE_categoryName___)
        }) {
            Row("Create new category") {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .rowOnSurface(backgroundColor: Color.surfaceSecondary)
        .surfaceContentMargins(.init(horizontal: .small, vertical: .small))
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
