// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import FactoryTesting
@testable import Main
import SwiftUI
import Testing

@Suite(.container)
@MainActor
struct ___VARIABLE_categoryName___ListViewModelTests {
    private func makeViewModel() -> (___VARIABLE_categoryName___ListViewState, ___VARIABLE_categoryName___ListViewModel) {
        let state = ___VARIABLE_categoryName___ListViewState(input: nil)
        state.storage.sortType = .date
        state.storage.sortOrder = .descending
        return (state, ___VARIABLE_categoryName___ListViewModel(state: state, input: nil, output: nil))
    }

    @Test func `appear loads categories`() async throws {
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Music")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onAppear)

        #expect(Set(state.state.result?.___VARIABLE_categoryPluralVariableName___.map(\.name) ?? []) == ["Video", "Music"])
    }

    @Test func `search and favorites compose`() async throws {
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video", isFavorite: true)
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video Games")
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Music", isFavorite: true)
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onChangeFilterType(.favorites))
        state.searchTerm = "video"
        await viewModel.handleAction(.onChangeSearchTerm(state.searchTerm))

        #expect(state.state.result?.___VARIABLE_categoryPluralVariableName___.map(\.name) == ["Video"])
    }

    @Test func `sort by name ascending orders alphabetically`() async throws {
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Music")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onChangeSortType(.name))
        await viewModel.handleAction(.onChangeSortOrder(.ascending))

        #expect(state.state.result?.___VARIABLE_categoryPluralVariableName___.map(\.name) == ["Music", "Video"])
    }

    @Test func `confirmed delete removes category`() async throws {
        let video = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onCategoryAction(.delete(video)))
        confirmDelete(state.alert)
        await waitUntil { state.state.result?.___VARIABLE_categoryPluralVariableName___.isEmpty == true }

        #expect(try await Container.shared.___VARIABLE_categoryVariableName___StorageService().fetch().isEmpty)
    }

    @Test func `duplicate double tap creates one copy`() async throws {
        let video = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let (state, viewModel) = makeViewModel()

        async let firstTap: Void = viewModel.handleAction(.onCategoryAction(.duplicate(video)))
        async let secondTap: Void = viewModel.handleAction(.onCategoryAction(.duplicate(video)))
        _ = await (firstTap, secondTap)

        #expect(Set(state.state.result?.___VARIABLE_categoryPluralVariableName___.map(\.name) ?? []) == ["Video", "Video (Copy)"])
    }

    @Test func `create callback refreshes list`() async throws {
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapCreate___VARIABLE_categoryName___)
        guard case let .___VARIABLE_categoryVariableName___Create(onSave) = state.destination else {
            Issue.record("Expected create destination")
            return
        }
        let video = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        onSave?(video)
        await waitUntil { state.state.result?.___VARIABLE_categoryPluralVariableName___.count == 1 }

        #expect(state.state.result?.___VARIABLE_categoryPluralVariableName___.first?.id == video.id)
    }
}
