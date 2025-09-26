//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryEditViewModel.swift, created on 27.07.2025
//

import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: MealProductCategoryEdit.self)
public actor MealProductCategoryEditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.mealProductCategoryStorageService) var mealProductCategoryStorageService: MealProductCategoryStorageService

    /// User Actions

    func onAppear() async {
        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: MealProductCategoryEditViewState.FocusField?) async {
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
            logError("Cannot save mealProductCategory, form is empty")
            return
        }
        await state.update { $0.isSaving = true }

        if await state.source == nil {
            do {
                let createdCategory = try await createMealProductCategory()
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
                let updatedCategory = try await updateMealProductCategory()
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

private extension MealProductCategoryEditViewModel {
    func fetchData() async {
        do {
            let mealProductCategory = try await fetchMealProductCategoryInternal()
            await state.update { viewState in
                viewState.mealProductCategoryState = .result(mealProductCategory)
                viewState.setFields(mealProductCategory: mealProductCategory)
            }
        } catch {
            await state.update { $0.mealProductCategoryState = .error(error) }
        }
    }

    func fetchMealProductCategory() async throws -> MealProductCategory {
        try await fetchMealProductCategoryInternal()
    }

    func createMealProductCategory() async throws -> MealProductCategory {
        let count = try await mealProductCategoryStorageService.count()
        return try await mealProductCategoryStorageService.save(
            name: state.name,
            emoji: state.emoji,
            color: state.color,
            date: state.date ?? Date(),
            image: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            index: count,
        )
    }

    func updateMealProductCategory() async throws -> MealProductCategory {
        guard let mealProductCategory = await state.mealProductCategoryState.successResult else {
            logError("Cannot update MealProductCategory - no product loaded")
            await state.update { $0.hud = .default("No category loaded") }
            throw SwiftDataError.itemNotFound
        }

        do {
            let updatedCategory = try await mealProductCategoryStorageService.update(
                mealProductCategory,
                name: state.name,
                emoji: state.emoji,
                color: state.color,
                date: state.date ?? Date(),
                image: state.image?.jpegData(compressionQuality: 0.5),
                note: state.note.isEmpty ? nil : state.note,
            )

            return updatedCategory
        } catch {
            logError("Failed to update MealProductCategory:", error: error)
            await state.update { $0.hud = .error(error) }
            throw error
        }
    }

    func fetchMealProductCategoryInternal() async throws -> MealProductCategory {
        try await mealProductCategoryStorageService.fetch(by: state.mealProductCategoryId)
    }
}
