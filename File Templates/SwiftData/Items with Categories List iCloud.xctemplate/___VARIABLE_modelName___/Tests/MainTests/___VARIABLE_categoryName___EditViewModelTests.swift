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
struct ___VARIABLE_categoryName___EditViewModelTests {
    private func makeViewModel(
        _ input: ___VARIABLE_categoryName___EditInput = .init(),
        output: ___VARIABLE_categoryName___EditOutput? = nil
    ) -> (___VARIABLE_categoryName___EditViewState, ___VARIABLE_categoryName___EditViewModel) {
        let state = ___VARIABLE_categoryName___EditViewState(input: input)
        return (state, ___VARIABLE_categoryName___EditViewModel(state: state, input: input, output: output))
    }

    @Test func `duplicate name marks form invalid`() async throws {
        try await TestData.makeCategory("Video")
        let (state, viewModel) = makeViewModel()
        state.form.name = "video"

        await viewModel.handleAction(.onFormChanged)

        #expect(state.isDuplicateName)
        #expect(state.isValidForm == false)
    }

    @Test func `unique name saves trimmed category once`() async throws {
        let recorder = CallbackRecorder<___VARIABLE_categoryName___>()
        let (state, viewModel) = makeViewModel(output: .init(onSave: recorder.callback))
        await viewModel.handleAction(.onAppear)
        state.form.name = "  Music  "
        await viewModel.handleAction(.onFormChanged)

        async let firstTap: Void = viewModel.handleAction(.onTapSave)
        async let secondTap: Void = viewModel.handleAction(.onTapSave)
        _ = await (firstTap, secondTap)

        let categories = try await Container.shared.___VARIABLE_categoryVariableName___StorageService().fetch()
        #expect(categories.map(\.name) == ["Music"])
        #expect(categories.first?.emoji == ___VARIABLE_categoryName___.defaultEmoji)
        #expect(recorder.values.count == 1)
        #expect(state.isDismissed)
    }

    @Test func `duplicate error on save marks current name`() async throws {
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)
        state.form.name = "Video"
        await viewModel.handleAction(.onFormChanged)
        #expect(state.isValidForm)
        try await TestData.makeCategory("Video")

        await viewModel.handleAction(.onTapSave)

        #expect(state.isDuplicateName)
        #expect(state.isValidForm == false)
        #expect(state.isDismissed == false)
    }

    @Test func `edit with model prefills form and keeps own name valid`() async throws {
        let video = try await TestData.makeCategory("Video")
        let (state, viewModel) = makeViewModel(.init(___VARIABLE_categoryVariableName___: video))

        await viewModel.handleAction(.onAppear)

        #expect(state.form.name == "Video")
        #expect(state.hasChanges == false)
        #expect(state.isDuplicateName == false)
        #expect(state.isValidForm)
    }

    @Test func `emoji change marks form dirty and saves`() async throws {
        let video = try await TestData.makeCategory("Video")
        let (state, viewModel) = makeViewModel(.init(___VARIABLE_categoryVariableName___: video))
        await viewModel.handleAction(.onAppear)

        state.form.emoji = "🎬"
        await viewModel.handleAction(.onFormChanged)
        #expect(state.hasChanges)
        await viewModel.handleAction(.onTapSave)

        let saved = try await Container.shared.___VARIABLE_categoryVariableName___StorageService().fetch(by: video.id)
        #expect(saved.emoji == "🎬")
        #expect(state.isDismissed)
    }

    @Test func `edit by id loads form and missing id publishes error`() async throws {
        let video = try await TestData.makeCategory("Video")
        let (loadedState, loadedViewModel) = makeViewModel(.init(id: video.id))
        let (missingState, missingViewModel) = makeViewModel(.init(id: UUID()))

        await loadedViewModel.handleAction(.onAppear)
        await missingViewModel.handleAction(.onAppear)

        #expect(loadedState.form.name == "Video")
        #expect(loadedState.hasChanges == false)
        #expect(missingState.___VARIABLE_categoryVariableName___State.isError)
    }
}
