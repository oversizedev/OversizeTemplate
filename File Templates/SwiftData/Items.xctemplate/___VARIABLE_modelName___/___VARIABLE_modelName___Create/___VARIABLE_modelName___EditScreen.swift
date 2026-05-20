// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizePhotoComponents
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___EditScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_modelName___EditViewState
    let reducer: Reducer<___VARIABLE_modelName___EditViewModel>
    @FocusState private var focusedField: ___VARIABLE_modelName___EditViewState.FocusField?

    // Initial

    public init(viewState: ___VARIABLE_modelName___EditViewState, reducer: Reducer<___VARIABLE_modelName___EditViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(
            viewState.title,
            content: content,
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: { toolbarContent })
        .navigationDismiss(trigger: $viewState.isDismissed)
        .presentationHUD($viewState.hud)
        .onChange(of: viewState.focusedField) { _, newValue in focusedField = newValue }
        .task { reducer.callAsFunction(.onAppear) }
        .onAppear { focusedField = .name }
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
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
            .focused($focusedField, equals: .name)
            .onChange(of: viewState.name) { reducer.callAsFunction(.onNameChanged($1)) }
    }

    private var noteField: some View {
        TextEditor(text: $viewState.note)
            .focused($focusedField, equals: .note)
            .submitLabel(.continue)
            .onSubmit { focusedField = .url }
            .textEditorPlaceholder("Note", text: $viewState.note)
            .onChange(of: viewState.note) { reducer.callAsFunction(.onNoteChanged($1)) }
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
            .onChange(of: viewState.url) { reducer.callAsFunction(.onUrlChanged($1)) }
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
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(action: { reducer.callAsFunction(.onTapSave) }) {
                Text(L10n.Button.save)
            }
            .disabled(!viewState.isValidForm)
            #if !os(tvOS)
                .keyboardShortcut(.defaultAction)
            #endif
        }
    }
}

// MARK: - Build Methods

extension ___VARIABLE_modelName___EditScreen {
    @MainActor
    static func build(handler: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.create, handler: handler)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildEdit(id: UUID, handler: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.editId(id), handler: handler)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, handler: Callback<___VARIABLE_modelName___EditViewState.CallbackAction>) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.edit(___VARIABLE_modelVariableName___), handler: handler)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }
}
