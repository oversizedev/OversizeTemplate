// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Edit.self)
public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {
    @LazyInjected(\.___VARIABLE_modelVariableName___StorageService) private var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @LazyInjected(\.___VARIABLE_categoryVariableName___StorageService) private var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    private var saveTask: Task<Void, Never>?

    // MARK: - User Actions

    func onAppear() async {
        await fetch___VARIABLE_modelName___Categories()
        if case let .id(id) = await state.source, await state.originalForm == nil {
            await fetch___VARIABLE_modelName___(id)
        }
        await updateFormValidation()
    }

    func onFormChanged() async {
        await updateFormValidation()
    }

    func onSelectCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        await state.update { $0.form.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___?.id }
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.isShow___VARIABLE_categoryName___Picker = false
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { ___VARIABLE_categoryVariableName___ in
                    Task { await self.selectCreatedCategory(___VARIABLE_categoryVariableName___) }
                }
            )
        }
    }

    func onTapSave() async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            let form = await state.form
            guard !form.trimmedName.isEmpty else { return }
            await state.update { $0.isSaving = true }
            defer { await state.update { $0.isSaving = false } }

            do {
                let ___VARIABLE_modelVariableName___ = if let loaded___VARIABLE_modelName___ = await state.___VARIABLE_modelVariableName___State.result {
                    try await update(loaded___VARIABLE_modelName___, with: form)
                } else if await state.source == nil {
                    try await create(form)
                } else {
                    throw PersistenceError.itemNotFound
                }
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isDismissed = true
                }
                output?.onSave?(___VARIABLE_modelVariableName___)
            } catch {
                Log.error("Failed to save ___VARIABLE_modelName___:", error: error)
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }
}

// MARK: - Mapping

extension ___VARIABLE_modelName___EditViewModel {
    nonisolated static func form(from ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) -> ___VARIABLE_modelName___EditViewState.Form {
        var form = ___VARIABLE_modelName___EditViewState.Form()
        form.name = ___VARIABLE_modelVariableName___.name
        form.note = ___VARIABLE_modelVariableName___.note ?? ""
        form.color = ___VARIABLE_modelVariableName___.color
        form.date = ___VARIABLE_modelVariableName___.date
        form.image = ___VARIABLE_modelVariableName___.imageData.flatMap { PlatformImage(data: $0) }
        form.___VARIABLE_categoryVariableName___Id = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id
        return form
    }

    nonisolated static func merge(
        draft: ___VARIABLE_modelName___EditViewState.Form,
        loaded: ___VARIABLE_modelName___EditViewState.Form
    ) -> ___VARIABLE_modelName___EditViewState.Form {
        let untouched = ___VARIABLE_modelName___EditViewState.Form()
        var form = loaded
        if draft.name != untouched.name {
            form.name = draft.name
        }
        if draft.note != untouched.note {
            form.note = draft.note
        }
        if draft.color != untouched.color {
            form.color = draft.color
        }
        if draft.date != untouched.date {
            form.date = draft.date
        }
        if draft.image != untouched.image {
            form.image = draft.image
        }
        if draft.___VARIABLE_categoryVariableName___Id != untouched.___VARIABLE_categoryVariableName___Id {
            form.___VARIABLE_categoryVariableName___Id = draft.___VARIABLE_categoryVariableName___Id
        }
        return form
    }

    nonisolated static func imageData(from image: PlatformImage?) throws -> Data? {
        guard let image else { return nil }
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            throw PersistenceError.validationFailed(reason: "Image could not be encoded")
        }
        return data
    }
}

// MARK: - Validation

private extension ___VARIABLE_modelName___EditViewModel {
    func updateFormValidation() async {
        await state.update { viewState in
            viewState.isValidForm = !viewState.form.trimmedName.isEmpty
            viewState.hasChanges = viewState.originalForm.map { $0 != viewState.form } ?? false
        }
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_modelName___EditViewModel {
    func fetch___VARIABLE_modelName___Categories() async {
        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch()
            await state.update { viewState in
                viewState.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___)
                if let categoryId = viewState.form.___VARIABLE_categoryVariableName___Id,
                   !___VARIABLE_categoryPluralVariableName___.contains(where: { $0.id == categoryId })
                {
                    viewState.form.___VARIABLE_categoryVariableName___Id = nil
                }
            }
        } catch {
            Log.error("Failed to fetch ___VARIABLE_modelName___Categories:", error: error)
            await state.update { viewState in
                viewState.___VARIABLE_categoryPluralVariableName___State = .error(error)
                viewState.alert = .error(error)
            }
        }
    }

    func fetch___VARIABLE_modelName___(_ id: UUID) async {
        do {
            let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(by: id)
            let form = Self.form(from: ___VARIABLE_modelVariableName___)
            await state.update { viewState in
                viewState.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                viewState.form = Self.merge(draft: viewState.form, loaded: form)
                viewState.originalForm = form
            }
        } catch {
            Log.error("Failed to fetch ___VARIABLE_modelName___:", error: error)
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    func selectCreatedCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await fetch___VARIABLE_modelName___Categories()
        await state.update { $0.form.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id }
    }
}

// MARK: - Write Operations

private extension ___VARIABLE_modelName___EditViewModel {
    func create(_ form: ___VARIABLE_modelName___EditViewState.Form) async throws -> ___VARIABLE_modelName___ {
        try await ___VARIABLE_modelVariableName___StorageService.save(
            name: form.trimmedName,
            color: form.color,
            date: form.date ?? Date(),
            imageData: Self.imageData(from: form.image),
            note: form.note.isEmpty ? nil : form.note,
            ___VARIABLE_categoryVariableName___Id: form.___VARIABLE_categoryVariableName___Id
        )
    }

    func update(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, with form: ___VARIABLE_modelName___EditViewState.Form) async throws -> ___VARIABLE_modelName___ {
        let originalImage = await state.originalForm?.image
        let image: Data?? = try form.image === originalImage ? nil : .some(Self.imageData(from: form.image))
        return try await ___VARIABLE_modelVariableName___StorageService.update(
            ___VARIABLE_modelVariableName___,
            name: form.trimmedName,
            color: form.color,
            date: form.date ?? Date(),
            image: image,
            note: .some(form.note.isEmpty ? nil : form.note),
            categoryId: .some(form.___VARIABLE_categoryVariableName___Id)
        )
    }
}
