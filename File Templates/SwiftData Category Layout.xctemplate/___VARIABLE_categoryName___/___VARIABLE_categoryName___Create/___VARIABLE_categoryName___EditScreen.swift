// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeResources
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___EditScreen: ViewProtocol {
    // States
    @Bindable var viewState: ___VARIABLE_categoryName___EditViewState
    let reducer: Reducer<___VARIABLE_categoryName___EditViewModel>

    // Initial
    @MainActor
    public init(viewState: ___VARIABLE_categoryName___EditViewState, reducer: Reducer<___VARIABLE_categoryName___EditViewModel>) {
        self.viewState = viewState
        self.reducer = reducer
    }

    public var body: some View {
        NavigationLayoutView(viewState.isEditMode ? "Edit ___VARIABLE_categoryName___" : "New ___VARIABLE_categoryName___") {
            content
        } background: {
            Color.backgroundPrimary
        }
        .toolbar(content: { toolbarContent })
        .toolbarTitleDisplayMode(.inline)
        .presentationHUD($viewState.hud)
        .presentationAlert($viewState.alert)
        .navigationMove($viewState.destination)
    }

    @ViewBuilder
    private var content: some View {
        ScrollView {
            LazyVStack(spacing: .large) {
                nameSection
                emojiSection
                colorSection
                noteSection
                
                if viewState.isEditMode {
                    detailsSection
                }
            }
            .paddingContent()
        }
    }

    @ViewBuilder
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Name")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            TextField("___VARIABLE_categoryName___ name", text: $viewState.name)
                .textFieldStyle(.default)
        }
    }

    @ViewBuilder
    private var emojiSection: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Emoji")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            TextField("Optional emoji", text: $viewState.emoji)
                .textFieldStyle(.default)
        }
    }

    @ViewBuilder
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Color")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: .medium) {
                    ForEach(___VARIABLE_categoryName___EditViewState.availableColors, id: \.self) { color in
                        Button {
                            viewState.selectedColor = color
                        } label: {
                            Circle()
                                .fill(color)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    if viewState.selectedColor == color {
                                        Circle()
                                            .stroke(Color.accent, lineWidth: 3)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    @ViewBuilder
    private var noteSection: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Note")
                .headline(.small)
                .foregroundColor(.onSurfaceHighEmphasis)

            TextField("Optional note", text: $viewState.note, axis: .vertical)
                .textFieldStyle(.default)
                .lineLimit(3...6)
        }
    }

    @ViewBuilder
    private var detailsSection: some View {
        if let ___VARIABLE_categoryVariableName___ = viewState.___VARIABLE_categoryVariableName___ {
            VStack(alignment: .leading, spacing: .small) {
                Text("Details")
                    .headline(.small)
                    .foregroundColor(.onSurfaceHighEmphasis)

                VStack(spacing: .zero) {
                    Row("Created", trailing: { Text(___VARIABLE_categoryVariableName___.date, style: .date) })
                    Row("View Count", trailing: { Text("\(___VARIABLE_categoryVariableName___.viewCount)") })
                    Row("Favorite", trailing: {
                        Toggle("", isOn: $viewState.isFavorite)
                            .labelsHidden()
                    })
                }
            }
        }
    }
}

// MARK: - Toolbar

private extension ___VARIABLE_categoryName___EditScreen {
    @ViewBuilder
    private func cancelButton() -> some View {
        Button("Cancel") {
            reducer.callAsFunction(.onTapCancel)
        }
    }

    @ViewBuilder
    private func saveButton() -> some View {
        Button("Save") {
            reducer.callAsFunction(.onTapSave)
        }
        .disabled(!viewState.isValid)
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            cancelButton()
        }

        ToolbarItem(placement: .confirmationAction) {
            saveButton()
        }
    }
}

public extension ___VARIABLE_categoryName___EditScreen {
    @MainActor
    static func buildCreate() -> some View {
        logNotice("Building ___VARIABLE_categoryName___EditScreen for creation")
        let viewState = ___VARIABLE_categoryName___EditViewState()
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: viewState)
        let reducer = Reducer(viewModel: viewModel)
        return ___VARIABLE_categoryName___EditScreen(viewState: viewState, reducer: reducer)
    }

    @MainActor
    static func buildEdit(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> some View {
        logNotice("Building ___VARIABLE_categoryName___EditScreen for editing \(___VARIABLE_categoryVariableName___.name)")
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
        ___VARIABLE_categoryName___EditScreen.buildEdit(
            ___VARIABLE_categoryVariableName___: .init(
                name: "Sample ___VARIABLE_categoryName___",
                emoji: "📁",
                color: .blue,
                date: Date(),
                note: "This is a sample note.",
                isFavorite: true,
                viewCount: 10,
                index: 0
            )
        )
    }
}