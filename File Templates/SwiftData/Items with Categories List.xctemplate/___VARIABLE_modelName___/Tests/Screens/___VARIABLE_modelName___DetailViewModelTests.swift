// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import FactoryTesting
@testable import Main
import SwiftUI
import Testing

@Suite(.container)
@MainActor
struct ___VARIABLE_modelName___DetailViewModelTests {
    private func makeViewModel(
        id: UUID,
        output: ___VARIABLE_modelName___DetailOutput? = nil
    ) -> (___VARIABLE_modelName___DetailViewState, ___VARIABLE_modelName___DetailViewModel) {
        let input = ___VARIABLE_modelName___DetailInput(id: id)
        let state = ___VARIABLE_modelName___DetailViewState(input: input)
        return (state, ___VARIABLE_modelName___DetailViewModel(state: state, input: input, output: output))
    }

    @Test func `appear loads ___VARIABLE_modelVariableName___ with categories`() async throws {
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix", categoryId: category.id)
        let (state, viewModel) = makeViewModel(id: netflix.id)

        await viewModel.handleAction(.onAppear)

        #expect(state.state.result?.___VARIABLE_modelVariableName___.name == "Netflix")
        #expect(state.state.result?.___VARIABLE_categoryVariableName___?.name == "Video")
    }

    @Test func `missing ___VARIABLE_modelVariableName___ publishes error`() async {
        let (state, viewModel) = makeViewModel(id: UUID())

        await viewModel.handleAction(.onAppear)

        #expect(state.state.isError)
    }

    @Test func `toggle favorite updates state and emits edit callback`() async throws {
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let recorder = CallbackRecorder<___VARIABLE_modelName___>()
        let (state, viewModel) = makeViewModel(id: netflix.id, output: .init(onEdit: recorder.callback))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapToggleFavorite)

        #expect(state.state.result?.___VARIABLE_modelVariableName___.isFavorite == true)
        #expect(recorder.values.map(\.isFavorite) == [true])
        #expect(state.hud != nil)
    }

    @Test func `select category updates ___VARIABLE_modelVariableName___`() async throws {
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel(id: netflix.id)
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapSelectCategory(category))
        #expect(state.state.result?.___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id == category.id)

        await viewModel.handleAction(.onTapSelectCategory(nil))
        #expect(state.state.result?.___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id == nil)
    }

    @Test func `confirmed delete dismisses once and emits delete callback`() async throws {
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let recorder = CallbackRecorder<___VARIABLE_modelName___>()
        let (state, viewModel) = makeViewModel(id: netflix.id, output: .init(onDelete: recorder.callback))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapDelete)
        confirmDelete(state.alert)
        await waitUntil { state.isDismissed }

        #expect(recorder.values.map(\.id) == [netflix.id])
        #expect(try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch().isEmpty)
    }

    @Test func `delete failure shows alert and keeps screen`() async throws {
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel(id: netflix.id)
        await viewModel.handleAction(.onAppear)
        try await Container.shared.___VARIABLE_modelVariableName___StorageService().delete(netflix)

        await viewModel.handleAction(.onTapDelete)
        confirmDelete(state.alert)
        await waitUntil {
            if case .error = state.alert {
                return true
            }
            return false
        }

        #expect(state.isDismissed == false)
    }

    @Test func `edit destination callback refreshes and emits`() async throws {
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let recorder = CallbackRecorder<___VARIABLE_modelName___>()
        let (state, viewModel) = makeViewModel(id: netflix.id, output: .init(onEdit: recorder.callback))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapEdit)
        guard case let .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, onSave) = state.destination else {
            Issue.record("Expected edit destination")
            return
        }
        #expect(___VARIABLE_modelVariableName___.id == netflix.id)

        let updated = try await Container.shared.___VARIABLE_modelVariableName___StorageService().update(netflix, name: "Netflix HD")
        onSave?(updated)
        await waitUntil { state.state.result?.___VARIABLE_modelVariableName___.name == "Netflix HD" }

        #expect(recorder.values.map(\.name) == ["Netflix HD"])
    }
}
