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
struct ___VARIABLE_categoryName___DetailViewModelTests {
    private func makeViewModel(
        id: UUID,
        output: ___VARIABLE_categoryName___DetailOutput? = nil
    ) -> (___VARIABLE_categoryName___DetailViewState, ___VARIABLE_categoryName___DetailViewModel) {
        let input = ___VARIABLE_categoryName___DetailInput(id: id)
        let state = ___VARIABLE_categoryName___DetailViewState(input: input)
        return (state, ___VARIABLE_categoryName___DetailViewModel(state: state, input: input, output: output))
    }

    @Test func `appear loads only ___VARIABLE_modelPluralVariableName___ of the category`() async throws {
        let video = try await TestData.makeCategory("Video")
        let music = try await TestData.makeCategory("Music")
        try await TestData.make___VARIABLE_modelName___("Netflix", categoryId: video.id)
        try await TestData.make___VARIABLE_modelName___("Spotify", categoryId: music.id)
        try await TestData.make___VARIABLE_modelName___("Dropbox")
        let (state, viewModel) = makeViewModel(id: video.id)

        await viewModel.handleAction(.onAppear)

        #expect(state.state.result?.___VARIABLE_categoryVariableName___.name == "Video")
        #expect(state.state.result?.___VARIABLE_modelPluralVariableName___.map(\.name) == ["Netflix"])
        #expect(state.state.result?.___VARIABLE_categoryPluralVariableName___.count == 2)
    }

    @Test func `toggle favorite emits updated category`() async throws {
        let video = try await TestData.makeCategory("Video")
        let recorder = CallbackRecorder<___VARIABLE_categoryName___>()
        let (state, viewModel) = makeViewModel(id: video.id, output: .init(onEdit: recorder.callback))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapToggleFavorite)

        #expect(state.state.result?.___VARIABLE_categoryVariableName___.isFavorite == true)
        #expect(recorder.values.map(\.isFavorite) == [true])
    }

    @Test func `confirmed delete dismisses and keeps ___VARIABLE_modelPluralVariableName___`() async throws {
        let video = try await TestData.makeCategory("Video")
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix", categoryId: video.id)
        let recorder = CallbackRecorder<___VARIABLE_categoryName___>()
        let (state, viewModel) = makeViewModel(id: video.id, output: .init(onDelete: recorder.callback))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapDelete)
        confirmDelete(state.alert)
        await waitUntil { state.isDismissed }

        #expect(recorder.values.map(\.id) == [video.id])
        #expect(try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch(by: netflix.id).___VARIABLE_categoryVariableName___Id == nil)
    }

    @Test func `delete without output still dismisses`() async throws {
        let video = try await TestData.makeCategory("Video")
        let (state, viewModel) = makeViewModel(id: video.id)
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapDelete)
        confirmDelete(state.alert)
        await waitUntil { state.isDismissed }

        #expect(state.isDismissed)
    }

    @Test func `child ___VARIABLE_modelVariableName___ delete refreshes without closing category`() async throws {
        let video = try await TestData.makeCategory("Video")
        let netflix = try await TestData.make___VARIABLE_modelName___("Netflix", categoryId: video.id)
        let (state, viewModel) = makeViewModel(id: video.id)
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.on___VARIABLE_modelName___Action(.delete(netflix)))
        confirmDelete(state.alert)
        await waitUntil { state.state.result?.___VARIABLE_modelPluralVariableName___.isEmpty == true }

        #expect(state.isDismissed == false)
        #expect(state.state.result?.___VARIABLE_categoryVariableName___.name == "Video")
    }
}
