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

public struct ___VARIABLE_categoryName___EditScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_categoryName___EditViewState
    let reducer: Reducer<___VARIABLE_categoryName___EditViewModel>
    @FocusState private var focusedField: ___VARIABLE_categoryName___EditViewState.FocusField?

    // Initial

    public init(viewState: ___VARIABLE_categoryName___EditViewState, reducer: Reducer<___VARIABLE_categoryName___EditViewModel>) {
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

            emojiField

            noteField

            #if !os(tvOS)
            colorField
            #endif

            #if os(iOS)
            imageField
            #endif
        }
        .fieldLabelPosition(.overInput)
        .controlRadius(.large)
        .paddingContent()
    }
}

// MARK: - Fields

private extension ___VARIABLE_categoryName___EditScreen {
    private var titleField: some View {
        TextField("Name", text: $viewState.name)
            .textFieldStyle(.placeholder("Name", text: $viewState.name))
            .submitLabel(.continue)
            .onSubmit { focusedField = .emoji }
            .focused($focusedField, equals: .name)
            .onChange(of: viewState.name) { reducer.callAsFunction(.onNameChanged($1)) }
    }

    private var emojiField: some View {
        TextField("Emoji (Optional)", text: $viewState.emoji)
            .textFieldStyle(.placeholder("🍎", text: $viewState.emoji))
            .submitLabel(.continue)
            .onSubmit { focusedField = .note }
            .focused($focusedField, equals: .emoji)
            .onChange(of: viewState.emoji) { reducer.callAsFunction(.onEmojiChanged($1)) }
    }

    private var noteField: some View {
        TextField("Note", text: $viewState.note, axis: .vertical)
            .lineLimit(2...6)
            .textFieldStyle(.placeholder("Note", text: $viewState.note))
            .submitLabel(.done)
            .focused($focusedField, equals: .note)
            .onChange(of: viewState.note) { reducer.callAsFunction(.onNoteChanged($1)) }
    }

    #if !os(tvOS)
    private var colorField: some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            HStack {
                Text("Color")
                    .subheadline(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            ColorPicker("Color", selection: $viewState.color, supportsOpacity: false)
                .labelsHidden()
                .onChange(of: viewState.color) { reducer.callAsFunction(.onColorChanged($1)) }
        }
    }
    #endif

    #if os(iOS)
    private var imageField: some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            HStack {
                Text("Image")
                    .subheadline(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            PhotoPicker(
                imageData: $viewState.imageData,
                placeholder: {
                    VStack(spacing: .small) {
                        Image.Camera.icon(.medium)
                            .foregroundStyle(.tertiary)
                        Text("Add Photo")
                            .caption(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: .large))
                }
            )
            .onChange(of: viewState.imageData) { reducer.callAsFunction(.onImageChanged($1)) }
        }
    }
    #endif
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___EditScreen {
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction) {
            Button(viewState.isEdit ? L10n.Button.save : L10n.Button.add) {
                reducer.callAsFunction(.onSave)
            }
            .disabled(!viewState.isValidForm)
        }

        ToolbarItem(placement: .cancellationAction) {
            Button(L10n.Button.cancel) {
                reducer.callAsFunction(.onCancel)
            }
        }
    }
}

public extension ___VARIABLE_categoryName___EditScreen {
    @MainActor
    static func buildCreate() -> some View {
        logNotice("Building ___VARIABLE_categoryName___EditScreen (Create)")
        let viewState = ___VARIABLE_categoryName___EditViewState()
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_categoryName___EditScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildEdit(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        logNotice("Building ___VARIABLE_categoryName___EditScreen (Edit)")
        let viewState = ___VARIABLE_categoryName___EditViewState(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_categoryName___EditScreen(viewState: viewState, reducer: reducer)
    }
}

#Preview("Create") {
    NavigationStack {
        ___VARIABLE_categoryName___EditScreen.buildCreate()
    }
}

#Preview("Edit") {
    NavigationStack {
        ___VARIABLE_categoryName___EditScreen.buildEdit(___VARIABLE_categoryVariableName___: .init(name: "Sample", emoji: "🍎", color: .red, date: .now))
    }
}