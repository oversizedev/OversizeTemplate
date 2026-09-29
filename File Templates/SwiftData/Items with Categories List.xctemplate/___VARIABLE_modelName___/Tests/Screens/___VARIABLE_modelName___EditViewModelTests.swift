// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import FactoryTesting
@testable import Main
import SwiftUI
import Testing

@Suite(.container)
@MainActor
struct ___VARIABLE_modelName___EditViewModelTests {
    private func makeViewModel(
        _ input: ___VARIABLE_modelName___EditInput = .init(),
        output: ___VARIABLE_modelName___EditOutput? = nil
    ) -> (___VARIABLE_modelName___EditViewState, ___VARIABLE_modelName___EditViewModel) {
        let state = ___VARIABLE_modelName___EditViewState(input: input)
        return (state, ___VARIABLE_modelName___EditViewModel(state: state, input: input, output: output))
    }

    @Test func `save trims name and creates one ___VARIABLE_modelVariableName___ on double tap`() async throws {
        let recorder = CallbackRecorder<___VARIABLE_modelName___>()
        let (state, viewModel) = makeViewModel(output: .init(onSave: recorder.callback))
        await viewModel.handleAction(.onAppear)
        state.form.name = "  Netflix  "
        await viewModel.handleAction(.onFormChanged)

        async let firstTap: Void = viewModel.handleAction(.onTapSave)
        async let secondTap: Void = viewModel.handleAction(.onTapSave)
        _ = await (firstTap, secondTap)

        let ___VARIABLE_modelPluralVariableName___ = try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch()
        #expect(___VARIABLE_modelPluralVariableName___.map(\.name) == ["Netflix"])
        #expect(recorder.values.count == 1)
        #expect(state.isDismissed)
        #expect(state.isSaving == false)
    }

    @Test func `blank name keeps form invalid and does not save`() async throws {
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)
        state.form.name = "   "

        await viewModel.handleAction(.onFormChanged)
        await viewModel.handleAction(.onTapSave)

        #expect(state.isValidForm == false)
        #expect(state.isDismissed == false)
        #expect(try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch().isEmpty)
    }

    @Test func `create form tracks changes`() async {
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)
        #expect(state.hasChanges == false)

        state.form.color = .red
        await viewModel.handleAction(.onFormChanged)

        #expect(state.hasChanges)
    }

    @Test func `edit with model prefills form without changes`() async throws {
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix", note: "Family", categoryId: category.id)
        let (state, viewModel) = makeViewModel(.init(___VARIABLE_modelVariableName___: netflix))

        #expect(state.form.name == "Netflix")
        #expect(state.form.note == "Family")
        #expect(state.form.___VARIABLE_categoryVariableName___Id == category.id)

        await viewModel.handleAction(.onAppear)

        #expect(state.hasChanges == false)
        #expect(state.isValidForm)
        #expect(state.selected___VARIABLE_categoryName___?.id == category.id)
    }

    @Test func `edit removes category and clears note`() async throws {
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix", note: "Family", categoryId: category.id)
        let (state, viewModel) = makeViewModel(.init(___VARIABLE_modelVariableName___: netflix))
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onSelectCategory(nil))
        state.form.note = ""
        await viewModel.handleAction(.onFormChanged)
        #expect(state.hasChanges)
        await viewModel.handleAction(.onTapSave)

        let saved = try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch(by: netflix.id)
        #expect(saved.___VARIABLE_categoryVariableName___Id == nil)
        #expect(saved.note == nil)
        #expect(state.isDismissed)
    }

    @Test func `edit by id loads form`() async throws {
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix")
        let (state, viewModel) = makeViewModel(.init(id: netflix.id))

        await viewModel.handleAction(.onAppear)

        #expect(state.form.name == "Netflix")
        #expect(state.hasChanges == false)
        #expect(state.isValidForm)
    }

    @Test func `late load keeps typed draft and fills untouched fields`() async throws {
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        let netflix = try await ___VARIABLE_modelName___TestData.make___VARIABLE_modelName___("Netflix", note: "Family", categoryId: category.id)
        let (state, viewModel) = makeViewModel(.init(id: netflix.id))
        state.form.name = "Draft"

        await viewModel.handleAction(.onAppear)

        #expect(state.form.name == "Draft")
        #expect(state.form.note == "Family")
        #expect(state.form.___VARIABLE_categoryVariableName___Id == category.id)
        #expect(state.originalForm?.name == "Netflix")
        #expect(state.hasChanges)

        await viewModel.handleAction(.onTapSave)

        let saved = try await Container.shared.___VARIABLE_modelVariableName___StorageService().fetch(by: netflix.id)
        #expect(saved.name == "Draft")
        #expect(saved.note == "Family")
        #expect(saved.___VARIABLE_categoryVariableName___Id == category.id)
    }

    @Test func `edit by missing id publishes error`() async {
        let (state, viewModel) = makeViewModel(.init(id: UUID()))

        await viewModel.handleAction(.onAppear)

        #expect(state.___VARIABLE_modelVariableName___State.isError)
        #expect(state.isValidForm == false)
    }

    @Test func `created category becomes selected`() async throws {
        let (state, viewModel) = makeViewModel()
        await viewModel.handleAction(.onAppear)

        await viewModel.handleAction(.onTapCreateCategory)
        guard case let .___VARIABLE_categoryVariableName___Create(onSave) = state.destination else {
            Issue.record("Expected create category destination")
            return
        }
        let category = try await ___VARIABLE_modelName___TestData.make___VARIABLE_categoryName___("Video")
        onSave?(category)
        await waitUntil { state.form.___VARIABLE_categoryVariableName___Id == category.id }

        #expect(state.selected___VARIABLE_categoryName___?.name == "Video")
        #expect(state.isShow___VARIABLE_categoryName___Picker == false)
    }
}
