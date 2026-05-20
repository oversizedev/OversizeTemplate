// ___FILEHEADER___

import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Edit.self)
public actor ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___CategoryStorageService) var ___VARIABLE_modelVariableName___CategoryStorageService: ___VARIABLE_categoryName___StorageService

    /// User Actions

    func onAppear() async {
        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: ___VARIABLE_categoryName___EditViewState.FocusField?) async {
        await state.update { $0.focusedField = field }
    }

    func onNameChanged(_ name: String) async {
        await updateFormValidation()
    }

    func onNoteChanged(_ note: String) async {
        await updateFormValidation()
    }

    func onUrlChanged(_ url: URL?) async {
        await updateFormValidation()
    }

    func updateFormValidation() async {
        await state.update { viewState in
            viewState.isEmptyForm = viewState.name.isEmpty && viewState.note.isEmpty
            viewState.isValidForm = !viewState.name.isEmpty
        }
    }

    func onTapSave() async {
        guard await !state.isEmptyForm else {
            logError("Cannot save ___VARIABLE_categoryVariableName___, form is empty")
            return
        }
        await state.update { $0.isSaving = true }

        if await state.source == nil {
            do {
                let createdCategory = try await create___VARIABLE_categoryName___()
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isSaving = false
                    viewState.isDismissed = true
                }
                output?.onSave?(createdCategory)
            } catch {
                await state.update { $0.isSaving = false }
            }
        } else {
            do {
                let updatedCategory = try await update___VARIABLE_categoryName___()
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isSaving = false
                    viewState.isDismissed = true
                }
                output?.onSave?(updatedCategory)
            } catch {
                await state.update { $0.isSaving = false }
            }
        }
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_categoryName___EditViewModel {
    func fetchData() async {
        do {
            let ___VARIABLE_categoryVariableName___ = try await fetch___VARIABLE_categoryName___Internal()
            await state.update { viewState in
                viewState.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
                viewState.setFields(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
            }
        } catch {
            await state.update { $0.___VARIABLE_categoryVariableName___State = .error(error) }
        }
    }

    func fetch___VARIABLE_categoryName___() async throws -> ___VARIABLE_categoryName___ {
        try await fetch___VARIABLE_categoryName___Internal()
    }

    func create___VARIABLE_categoryName___() async throws -> ___VARIABLE_categoryName___ {
        let count = try await ___VARIABLE_modelVariableName___CategoryStorageService.count()
        return try await ___VARIABLE_modelVariableName___CategoryStorageService.save(
            name: state.name,
            emoji: state.emoji,
            color: state.color,
            date: state.date ?? Date(),
            image: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            index: count,
        )
    }

    func update___VARIABLE_categoryName___() async throws -> ___VARIABLE_categoryName___ {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.result else {
            logError("Cannot update ___VARIABLE_categoryName___ - no product loaded")
            await state.update { $0.hud = .default("No category loaded") }
            throw SwiftDataError.itemNotFound
        }

        do {
            let updatedCategory = try await ___VARIABLE_modelVariableName___CategoryStorageService.update(
                ___VARIABLE_categoryVariableName___,
                name: state.name,
                emoji: state.emoji,
                color: state.color,
                date: state.date ?? Date(),
                image: state.image?.jpegData(compressionQuality: 0.5),
                note: state.note.isEmpty ? nil : state.note,
            )

            return updatedCategory
        } catch {
            logError("Failed to update ___VARIABLE_categoryName___:", error: error)
            await state.update { $0.hud = .error(error) }
            throw error
        }
    }

    func fetch___VARIABLE_categoryName___Internal() async throws -> ___VARIABLE_categoryName___ {
        try await ___VARIABLE_modelVariableName___CategoryStorageService.fetch(by: state.___VARIABLE_categoryVariableName___Id)
    }
}