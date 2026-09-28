// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Edit.self)
public actor ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    private var saveTask: Task<Void, Never>?

    // User Actions

    func onAppear() async {
        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: ___VARIABLE_categoryName___EditViewState.FocusField?) async {
        await state.update { $0.focusedField = field }
    }

    func onNameChanged(_: String) async {
        await updateFormValidation()
    }

    func onNoteChanged(_: String) async {
        await updateFormValidation()
    }

    func onUrlChanged(_: URL?) async {
        await updateFormValidation()
    }

    func onColorChanged(_: Color) async {
        await updateFormValidation()
    }

    func onDateChanged(_: Date?) async {
        await updateFormValidation()
    }

    func onImageChanged(_: UIImage?) async {
        await updateFormValidation()
    }

    func onEmojiChanged(_: String) async {
        await updateFormValidation()
    }

    func updateFormValidation() async {
        let trimmedName = await state.trimmedName

        guard !trimmedName.isEmpty else {
            await state.update { viewState in
                guard viewState.trimmedName == trimmedName else { return }
                viewState.isEmptyForm = viewState.note.isEmpty
                viewState.isDuplicateName = false
                viewState.isValidForm = false
            }
            return
        }

        let excludingId: UUID? = await state.source == nil ? nil : state.___VARIABLE_categoryVariableName___Id

        var isDuplicate = false
        do {
            isDuplicate = try await ___VARIABLE_categoryVariableName___StorageService.isNameTaken(trimmedName, excludingId: excludingId)
        } catch {
            Log.error("Failed to check ___VARIABLE_categoryVariableName___ name uniqueness:", error: error)
        }

        await state.update { viewState in
            guard viewState.trimmedName == trimmedName else { return }
            viewState.isEmptyForm = false
            viewState.isDuplicateName = isDuplicate
            viewState.isValidForm = !isDuplicate
        }
    }

    func onTapSave() async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            guard await !state.isEmptyForm, await state.isValidForm else { return }
            await state.update { $0.isSaving = true }
            defer { await state.update { $0.isSaving = false } }

            do {
                let ___VARIABLE_categoryVariableName___ = if await state.source == nil {
                    try await create___VARIABLE_categoryName___()
                } else {
                    try await update___VARIABLE_categoryName___()
                }
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isDismissed = true
                }
                output?.onSave?(___VARIABLE_categoryVariableName___)
            } catch PersistenceError.duplicateItem {
                await state.update { viewState in
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

// MARK: - Data Fetching

private extension ___VARIABLE_categoryName___EditViewModel {
    func fetchData() async {
        do {
            let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch(by: state.___VARIABLE_categoryVariableName___Id)
            await state.update { viewState in
                viewState.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
                viewState.name = ___VARIABLE_categoryVariableName___.name
                viewState.emoji = ___VARIABLE_categoryVariableName___.emoji ?? "🥕"
                viewState.note = ___VARIABLE_categoryVariableName___.note ?? ""
                viewState.color = ___VARIABLE_categoryVariableName___.color
                viewState.date = ___VARIABLE_categoryVariableName___.date
                #if os(macOS)
                    viewState.image = ___VARIABLE_categoryVariableName___.imageData.flatMap { NSImage(data: $0) }
                #else
                    viewState.image = ___VARIABLE_categoryVariableName___.imageData.flatMap { UIImage(data: $0) }
                #endif
                viewState.originalImage = viewState.image
            }
            await updateFormValidation()
        } catch {
            await state.update { $0.___VARIABLE_categoryVariableName___State = .error(error) }
        }
    }

    func create___VARIABLE_categoryName___() async throws -> ___VARIABLE_categoryName___ {
        let count = try await ___VARIABLE_categoryVariableName___StorageService.count()
        return try await ___VARIABLE_categoryVariableName___StorageService.save(
            name: state.trimmedName,
            emoji: state.emoji,
            color: state.color,
            date: state.date ?? Date(),
            image: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            index: count
        )
    }

    func update___VARIABLE_categoryName___() async throws -> ___VARIABLE_categoryName___ {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.result else {
            Log.error("Cannot update ___VARIABLE_categoryName___ - no category loaded")
            throw PersistenceError.itemNotFound
        }
        let image: Data?? = await state.isImageChanged
            ? .some(state.image?.jpegData(compressionQuality: 0.5))
            : .none
        return try await ___VARIABLE_categoryVariableName___StorageService.update(
            ___VARIABLE_categoryVariableName___,
            name: state.trimmedName,
            emoji: .some(state.emoji),
            color: state.color,
            date: state.date ?? Date(),
            image: image,
            note: .some(state.note.isEmpty ? nil : state.note)
        )
    }
}
