// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizePhotoComponents
import OversizeRouter
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___EditScreen {
    static func build() -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.create)
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___EditReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(id: String) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.editId(id))
        let viewModel = ___VARIABLE_modelName___EditViewModel(state: viewState)
        let reducer = ___VARIABLE_modelName___EditReducer(viewModel: viewModel)
        return ___VARIABLE_modelName___EditScreen(viewState: viewState, reducer: reducer)
    }

    static func buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> some View {
        let viewState = ___VARIABLE_modelName___EditViewState(.edit(___VARIABLE_modelVariableName___))
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
        NavigationPageView(
            viewState.title,
            content: content
        )
        .backConfirmationDialog(viewState.isEmptyForm ? nil : .discard)
        .toolbarTitleDisplayMode(.inline)
        .toolbar(content: toolbarContent)
        .task { reducer.callAsFunction(.onAppear) }
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
