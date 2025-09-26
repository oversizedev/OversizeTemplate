//
// Copyright © 2025 Alexander Romanov
// MealProductEditViewModel.swift, created on 10.07.2025
//

import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: MealProductEdit.self)
public actor MealProductEditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.mealProductStorageService) var mealProductStorageService: MealProductStorageService
    @Injected(\.mealProductCategoryStorageService) var mealProductCategoryStorageService: MealProductCategoryStorageService

    func onAppear() async {
        await fetchCategories()

        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: MealProductEditViewState.FocusField?) async {
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

    func onCategorySelected(_ category: MealProductCategory?) async {
        await state.update { $0.selectedCategory = category }
        logDebug("Category selected: \(category?.name ?? "None")")
    }

    func onCategoryCreated(_ category: MealProductCategory) async {
        logDebug("Category created: \(category.name)")
        await fetchCategories()
        await state.update { $0.selectedCategory = category }
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.isShowCategoryPicker = false
            viewState.destination = .mealProductCategoryCreate(
                onSave: { category in
                    Task {
                        await self.onCategoryCreated(category)
                    }
                }
            )
        }
    }

    func updateFormValidation() async {
        await state.update { viewState in
            viewState.isEmptyForm = viewState.name.isEmpty && viewState.note.isEmpty
            viewState.isValidForm = !viewState.name.isEmpty
        }
        await logDebug("Form validation changed - valid: \(state.isValidForm)")
    }

    func onTapSave() async {
        guard await !state.isEmptyForm else {
            logError("Cannot save meal product, form is empty")
            return
        }
        await state.update { $0.isSaving = true }

        if await state.source == nil {
            do {
                let product = try await createMealProduct()
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isSaving = false
                    viewState.isDismissed = true
                }
                output?.onSave?(product)
            } catch {
                await state.update { $0.isSaving = false }
            }

        } else {
            await state.update {
                $0.hud = .success
                $0.isSaving = false
                $0.isDismissed = true
            }
            if let product = await updateMealProduct() {
                output?.onSave?(product)
            }
        }
    }
}

// MARK: - Data Fetching

public extension MealProductEditViewModel {
    func fetchCategories() async {
        do {
            let categories = try await mealProductCategoryStorageService.fetch()
            await state.update { viewState in
                viewState.categoriesState = .result(categories)
                viewState.setCategories(categories)
            }
        } catch {
            await state.update { $0.categoriesState = .error(error) }
            logError("Failed to fetch categories:", error: error)
        }
    }

    func fetchData() async {
        do {
            let mealProduct = try await fetchMealProduct()
            await state.update { viewState in
                viewState.mealProductState = .result(mealProduct)
                viewState.setFields(mealProduct: mealProduct)
            }
        } catch {
            await state.update { $0.mealProductState = .error(error) }
        }
    }

    private func fetchMealProduct() async throws -> MealProduct {
        try await mealProductStorageService.fetch(by: state.mealProductId)
    }

    func createMealProduct() async throws -> MealProduct {
        try await mealProductStorageService.save(
            name: state.name,
            color: state.color,
            date: state.date ?? Date(),
            imageData: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            categoryId: state.selectedCategory?.id
        )
    }

    func updateMealProduct() async -> MealProduct? {
        guard let mealProduct = await state.mealProductState.successResult else {
            logError("Cannot update MealProduct - no product loaded")
            await state.update { $0.hud = .destructive("Failed to load product data") }
            return nil
        }
        do {
            let updatedProduct = try await mealProductStorageService.update(
                mealProduct,
                name: state.name,
                color: state.color,
                date: state.date ?? Date(),
                image: state.image?.jpegData(compressionQuality: 0.5),
                note: state.note.isEmpty ? nil : state.note
            )

            let finalProduct = try await mealProductStorageService.updateCategory(
                updatedProduct,
                categoryId: state.selectedCategory?.id
            )
            return finalProduct
        } catch {
            logError("Failed to update MealProduct:", error: error)
            await state.update { $0.hud = .destructive("Failed to update product") }
            return nil
        }
    }
}
