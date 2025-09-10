// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___EditScreen: View {
    @StateObject private var viewModel: ___VARIABLE_categoryName___EditViewModel
    private let reducer: Reducer<___VARIABLE_categoryName___EditViewModel>

    public init(viewModel: ___VARIABLE_categoryName___EditViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        reducer = Reducer(viewModel: viewModel)
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: .large) {
                    // Name field
                    VStack(alignment: .leading, spacing: .small) {
                        Text("Name")
                            .headline(.small)
                            .foregroundStyle(.primary)

                        TextField("Enter ___VARIABLE_categoryVariableName___ name", text: $viewModel.state.name)
                            .textFieldStyle(.roundedBorder)
                    }

                    // Description field
                    VStack(alignment: .leading, spacing: .small) {
                        Text("Description")
                            .headline(.small)
                            .foregroundStyle(.primary)

                        TextField("Enter description (optional)", text: $viewModel.state.description, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(3...6)
                    }

                    // Color picker
                    VStack(alignment: .leading, spacing: .small) {
                        Text("Color")
                            .headline(.small)
                            .foregroundStyle(.primary)

                        ColorPicker("Category Color", selection: $viewModel.state.color, supportsOpacity: false)
                            .labelsHidden()
                    }

                    // Toggle options
                    VStack(spacing: .medium) {
                        Row(
                            "Favorite",
                            subtitle: "Mark as favorite ___VARIABLE_categoryVariableName___",
                            trailing: {
                                Toggle("", isOn: $viewModel.state.isFavorite)
                                    .labelsHidden()
                            }
                        )

                        Row(
                            "Archive",
                            subtitle: "Archive this ___VARIABLE_categoryVariableName___",
                            trailing: {
                                Toggle("", isOn: $viewModel.state.isArchive)
                                    .labelsHidden()
                            }
                        )
                    }

                    Spacer()
                }
                .paddingContent()
            }
            .navigationTitle(viewModel.state.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        reducer(.onCancel)
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        reducer(.onSave)
                    }
                    .disabled(!viewModel.state.isValid)
                }
            }
        }
        .alert(using: $viewModel.state.alert)
        .hud(using: $viewModel.state.hud)
    }
}

// MARK: - Builders

public extension ___VARIABLE_categoryName___EditScreen {
    @MainActor
    static func build(handler: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>) -> some View {
        let state = ___VARIABLE_categoryName___EditViewState(callback: handler)
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: state)
        return ___VARIABLE_categoryName___EditScreen(viewModel: viewModel)
    }

    @MainActor
    static func buildEdit(id: UUID, handler: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>) -> some View {
        // This would typically fetch the category by ID first
        let state = ___VARIABLE_categoryName___EditViewState(callback: handler)
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: state)
        return ___VARIABLE_categoryName___EditScreen(viewModel: viewModel)
    }

    @MainActor
    static func buildEdit(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, handler: Callback<___VARIABLE_categoryName___EditViewState.CallbackAction>) -> some View {
        let state = ___VARIABLE_categoryName___EditViewState(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___, callback: handler)
        let viewModel = ___VARIABLE_categoryName___EditViewModel(state: state)
        return ___VARIABLE_categoryName___EditScreen(viewModel: viewModel)
    }
}