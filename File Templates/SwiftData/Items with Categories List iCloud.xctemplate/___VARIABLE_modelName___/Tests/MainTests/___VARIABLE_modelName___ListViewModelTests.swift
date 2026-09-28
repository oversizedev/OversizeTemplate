// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import FactoryTesting
@testable import Main
import Models
import SwiftUI
import Testing

@Suite(.container)
@MainActor
struct ___VARIABLE_modelName___ListViewModelTests {
    private func makeViewModel() -> (___VARIABLE_modelName___ListViewState, ___VARIABLE_modelName___ListViewModel) {
        let state = ___VARIABLE_modelName___ListViewState(input: nil)
        state.storage.sortType = .date
        state.storage.sortOrder = .descending
        return (state, ___VARIABLE_modelName___ListViewModel(state: state, input: nil, output: nil))
    }

    @Test func `appear loads ___VARIABLE_modelPluralVariableName___ and categories`() async throws {
        let category = try await TestData.makeCategory("Video")
        try await TestData.make___VARIABLE_modelName___("Netflix", categoryId: category.id)
        try await TestData.make___VARIABLE_modelName___("Spotify")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onAppear)

        #expect(Set(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) ?? []) == ["Netflix", "Spotify"])
        #expect(state.state.result?.___VARIABLE_categoryPluralVariableName___.map(\.name) == ["Video"])
    }

    @Test func `search matches name and note`() async throws {
        try await TestData.make___VARIABLE_modelName___("Netflix", note: "Streaming")
        try await TestData.make___VARIABLE_modelName___("Spotify", note: "Music")
        let (state, viewModel) = makeViewModel()

        state.searchTerm = "music"
        await viewModel.handleAction(.onChangeSearchTerm(state.searchTerm))

        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) == ["Spotify"])
    }

    @Test func `favorites filter shows only favorites`() async throws {
        try await TestData.make___VARIABLE_modelName___("Netflix", isFavorite: true)
        try await TestData.make___VARIABLE_modelName___("Spotify")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onChangeFilterType(.favorites))

        #expect(state.filterType == .favorites)
        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) == ["Netflix"])
    }

    @Test func `sort by name ascending orders alphabetically`() async throws {
        try await TestData.make___VARIABLE_modelName___("Spotify")
        try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.onChangeSortType(.name))
        await viewModel.handleAction(.onChangeSortOrder(.ascending))

        #expect(state.storage.sortType == .name)
        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) == ["Netflix", "Spotify"])
    }

    @Test func `stale search result is dropped`() async throws {
        try await TestData.make___VARIABLE_modelName___("Netflix")
        try await TestData.make___VARIABLE_modelName___("Spotify")
        let (state, viewModel) = makeViewModel()

        state.searchTerm = "Net"
        async let first: Void = viewModel.handleAction(.onChangeSearchTerm("Net"))
        state.searchTerm = "Spo"
        async let second: Void = viewModel.handleAction(.onChangeSearchTerm("Spo"))
        _ = await (first, second)

        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) == ["Spotify"])
    }

    @Test func `confirmed delete removes ___VARIABLE_modelVariableName___ and shows hud`() async throws {
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.delete(netflix)))
        confirmDelete(state.alert)
        await waitUntil { state.state.result?.___VARIABLE_modelPluralVariableName___.isEmpty == true }

        #expect(try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch().isEmpty)
        #expect(state.hud != nil)
    }

    @Test func `duplicate double tap creates one copy`() async throws {
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()

        async let firstTap: Void = viewModel.handleAction(.on___VARIABLE_modelName___Action(.duplicate(netflix)))
        async let secondTap: Void = viewModel.handleAction(.on___VARIABLE_modelName___Action(.duplicate(netflix)))
        _ = await (firstTap, secondTap)

        #expect(Set(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) ?? []) == ["Netflix", "Netflix (Copy)"])
    }

    @Test func `toggle favorite uses persisted value`() async throws {
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.toggleFavorite(netflix)))
        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.toggleFavorite(netflix)))

        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.first?.isFavorite == false)
    }

    @Test func `created category is assigned to requested ___VARIABLE_modelVariableName___`() async throws {
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()

        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.createCategory(for: netflix)))
        guard case let .___VARIABLE_categoryVariableName___Create(onSave) = state.destination else {
            Issue.record("Expected create category destination")
            return
        }
        let category = try await TestData.makeCategory("Video")
        onSave?(category)
        await waitUntil { state.state.result?.___VARIABLE_modelPluralVariableName___.first?.___VARIABLE_categoryVariableName___Id == category.id }

        #expect(try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch(by: netflix.id).___VARIABLE_categoryVariableName___Id == category.id)
    }

    @Test func `opening detail sets destination and delete callback refreshes`() async throws {
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.open(netflix)))
        guard case let .___VARIABLE_modelVariableName___Detail(___VARIABLE_modelVariableName___, _, onDelete) = state.destination else {
            Issue.record("Expected detail destination")
            return
        }
        #expect(___VARIABLE_modelVariableName___.id == netflix.id)

        try await Container.shared.___VARIABLE_modelVariableName___StorageService().delete(netflix)
        onDelete?(netflix)
        await waitUntil { state.state.result?.___VARIABLE_modelPluralVariableName___.isEmpty == true }

        #expect(state.hud != nil)
    }
}
