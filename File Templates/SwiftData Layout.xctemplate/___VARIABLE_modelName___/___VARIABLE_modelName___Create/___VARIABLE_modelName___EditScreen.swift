// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizePhotoComponents
import OversizeNavigation
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___EditScreen {
    static func build(callback: @escaping (___VARIABLE_modelName___) -> Void = { _ in }) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.create, callback: callback)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___EditReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(id: UUID, callback: @escaping (___VARIABLE_modelName___) -> Void = { _ in }) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.editId(id), callback: callback)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___EditReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, callback: @escaping (___VARIABLE_modelName___) -> Void = { _ in }) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.edit(___VARIABLE_modelVariableName___), callback: callback)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___EditReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }
}

public struct ___VARIABLE_modelName___EditScreen: View {
    @Environment(\.platform) private var platform

    // States
    @State var viewState: ___VARIABLE_modelName___EditViewState
    let reducer: ___VARIABLE_modelName___EditReducer
    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewState.FocusField?

    // Initial
    public init(viewState: ___VARIABLE_modelName___EditViewState, reducer: ___VARIABLE_modelName___EditReducer) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.hasChangedFromOriginal ? .discard : nil)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: toolbarContent)
        .alert(item: $viewState.alert) { $0.alert }
        .confirmationDialog(
            "Delete ___VARIABLE_modelName___",
            isPresented: $viewState.isShowingDeleteConfirmation
        ) {
            Button("Delete", role: .destructive) {
                reducer.callAsFunction(.onConfirmDelete)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This action cannot be undone.")
        }
        .confirmationDialog(
            "Discard Changes",
            isPresented: $viewState.isShowingDiscardConfirmation
        ) {
            Button("Discard", role: .destructive) {
                reducer.callAsFunction(.onConfirmDiscard)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You have unsaved changes that will be lost.")
        }
        .task { reducer.callAsFunction(.onAppear) }
        .onChange(of: viewState.focusedField) { focusedField = $1 }
        .onChange(of: viewState.name) { _ in
            reducer.callAsFunction(.onValidateName)
        }
        .onChange(of: viewState.note) { _ in
            reducer.callAsFunction(.onValidateNote)
        }
        .onChange(of: viewState.date) { _ in
            reducer.callAsFunction(.onValidateDate)
        }
        .onChange(of: viewState.image) { _ in
            reducer.callAsFunction(.onImageChanged)
        }
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
        VStack(alignment: .leading, spacing: .xxSmall) {
            TextField("Name", text: $viewState.name)
                .textFieldStyle(.placeholder("Name", text: $viewState.name))
                .focused($focusedField, equals: .name)
                .submitLabel(.continue)
                .onSubmit { focusedField = .note }
            
            if let nameError = viewState.nameError {
                Text(nameError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }

    private var noteField: some View {
        VStack(alignment: .leading, spacing: .xxSmall) {
            TextEditor(text: $viewState.note)
                .focused($focusedField, equals: .note)
                .submitLabel(.continue)
                .onSubmit { focusedField = .url }
                .textEditorPlaceholder("Note", text: $viewState.note)
                .frame(minHeight: 80)
            
            HStack {
                if let noteError = viewState.noteError {
                    Text(noteError)
                        .font(.caption)
                        .foregroundStyle(.red)
                } else {
                    Spacer()
                }
                
                Text("\(viewState.note.count)/500")
                    .font(.caption)
                    .foregroundStyle(viewState.note.count > 500 ? .red : .secondary)
            }
        }
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
        VStack(alignment: .leading, spacing: .xxSmall) {
            DateField(selection: $viewState.date)
            
            if let dateError = viewState.dateError {
                Text(dateError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
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
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") {
                reducer.callAsFunction(.onTapCancel)
            }
        }
        
        ToolbarItem(placement: .confirmationAction) {
            Button {
                reducer.callAsFunction(.onTapSave)
            } label: {
                if viewState.isSaving {
                    ProgressView()
                        .controlSize(.small)
                } else {
                    Text(L10n.Button.save)
                }
            }
            .disabled(!viewState.isValidForm || viewState.isSaving)
            #if !os(tvOS)
                .keyboardShortcut(.defaultAction)
            #endif
        }
        
        // Additional actions for edit mode
        if case .edit = viewState.mode {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Reset") {
                    reducer.callAsFunction(.onTapReset)
                }
                .disabled(viewState.isSaving || viewState.isDeleting)
                
                Spacer()
                
                Menu {
                    Button("Duplicate") {
                        reducer.callAsFunction(.onTapDuplicate)
                    }
                    
                    Divider()
                    
                    Button("Delete", role: .destructive) {
                        reducer.callAsFunction(.onTapDelete)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .disabled(viewState.isSaving || viewState.isDeleting)
            }
        }
    }
}
