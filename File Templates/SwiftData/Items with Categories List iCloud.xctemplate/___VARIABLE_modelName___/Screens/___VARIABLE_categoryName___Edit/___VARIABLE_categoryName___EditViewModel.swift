// ___FILEHEADER___

import Services
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Edit.self)
public actor ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    @Injected(\.___VARIABLE_categoryVariableName___Service) private var ___VARIABLE_categoryVariableName___Service: ___VARIABLE_categoryName___Service

    private var saveTask: Task<Void, Never>?

    // MARK: - User Actions

    func onAppear() async {
        if case let .id(id) = await state.source, await state.originalForm == nil {
            await fetch___VARIABLE_categoryName___(id)
        }
        await updateFormValidation()
    }

    func onFormChanged() async {
        await updateFormValidation()
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
                let ___VARIABLE_categoryVariableName___ = if let loadedCategory = await state.___VARIABLE_categoryVariableName___State.result {
                    try await update(loadedCategory, with: form)
                } else if await state.source == nil {
                    try await create(form)
                } else {
                    throw PersistenceError.itemNotFound
                }
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isDismissed = true
                }
                output?.onSave?(___VARIABLE_categoryVariableName___)
            } catch PersistenceError.duplicateItem {
                await state.update { viewState in
                    guard viewState.form.trimmedName == form.trimmedName else { return }
                    viewState.isDuplicateName = true
                    viewState.isValidForm = false
                }
            } catch {
                Log.error("Failed to save ___VARIABLE_categoryName___:", error: error)
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }
}

// MARK: - Mapping

extension ___VARIABLE_categoryName___EditViewModel {
    nonisolated static func form(from ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) -> ___VARIABLE_categoryName___EditViewState.Form {
        var form = ___VARIABLE_categoryName___EditViewState.Form()
        form.name = ___VARIABLE_categoryVariableName___.name
        form.note = ___VARIABLE_categoryVariableName___.note ?? ""
        form.emoji = ___VARIABLE_categoryVariableName___.displayEmoji
        form.color = ___VARIABLE_categoryVariableName___.color
        form.date = ___VARIABLE_categoryVariableName___.date
        form.image = ___VARIABLE_categoryVariableName___.imageData.flatMap { PlatformImage(data: $0) }
        return form
    }

    nonisolated static func merge(
        draft: ___VARIABLE_categoryName___EditViewState.Form,
        loaded: ___VARIABLE_categoryName___EditViewState.Form
    ) -> ___VARIABLE_categoryName___EditViewState.Form {
        let untouched = ___VARIABLE_categoryName___EditViewState.Form()
        var form = loaded
        if draft.name != untouched.name {
            form.name = draft.name
        }
        if draft.note != untouched.note {
            form.note = draft.note
        }
        if draft.emoji != untouched.emoji {
            form.emoji = draft.emoji
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

private extension ___VARIABLE_categoryName___EditViewModel {
    func updateFormValidation() async {
        let form = await state.form
        let trimmedName = form.trimmedName

        await state.update { viewState in
            viewState.hasChanges = viewState.originalForm.map { $0 != viewState.form } ?? false
        }

        guard !trimmedName.isEmpty else {
            await state.update { viewState in
                guard viewState.form.trimmedName == trimmedName else { return }
                viewState.isDuplicateName = false
                viewState.isValidForm = false
            }
            return
        }

        let excludingId: UUID? = await state.source == nil ? nil : state.___VARIABLE_categoryVariableName___Id
        var isDuplicate = false
        do {
            isDuplicate = try await ___VARIABLE_categoryVariableName___Service.isNameTaken(trimmedName, excludingId: excludingId)
        } catch {
            Log.error("Failed to check ___VARIABLE_categoryName___ name uniqueness:", error: error)
        }

        await state.update { viewState in
            guard viewState.form.trimmedName == trimmedName else { return }
            viewState.isDuplicateName = isDuplicate
            viewState.isValidForm = !isDuplicate
        }
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_categoryName___EditViewModel {
    func fetch___VARIABLE_categoryName___(_ id: UUID) async {
        do {
            let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_categoryVariableName___Service.fetch(by: id)
            let form = Self.form(from: ___VARIABLE_categoryVariableName___)
            await state.update { viewState in
                viewState.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
                viewState.form = Self.merge(draft: viewState.form, loaded: form)
                viewState.originalForm = form
            }
        } catch {
            Log.error("Failed to fetch ___VARIABLE_categoryName___:", error: error)
            await state.update { $0.___VARIABLE_categoryVariableName___State = .error(error) }
        }
    }
}

// MARK: - Write Operations

private extension ___VARIABLE_categoryName___EditViewModel {
    func create(_ form: ___VARIABLE_categoryName___EditViewState.Form) async throws -> ___VARIABLE_categoryName___ {
        let count = try await ___VARIABLE_categoryVariableName___Service.count()
        return try await ___VARIABLE_categoryVariableName___Service.save(
            name: form.trimmedName,
            emoji: form.emoji,
            color: form.color,
            date: form.date ?? Date(),
            image: Self.imageData(from: form.image),
            note: form.note.isEmpty ? nil : form.note,
            index: count
        )
    }

    func update(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, with form: ___VARIABLE_categoryName___EditViewState.Form) async throws -> ___VARIABLE_categoryName___ {
        let originalImage = await state.originalForm?.image
        let image: Data?? = try form.image === originalImage ? nil : .some(Self.imageData(from: form.image))
        return try await ___VARIABLE_categoryVariableName___Service.update(
            ___VARIABLE_categoryVariableName___,
            name: form.trimmedName,
            emoji: .some(form.emoji),
            color: form.color,
            date: form.date ?? Date(),
            image: image,
            note: .some(form.note.isEmpty ? nil : form.note)
        )
    }
}
