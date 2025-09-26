// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Edit.self)
public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetchCategories()

        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
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

    func onCategorySelected(_ category: ___VARIABLE_categoryName___?) async {
        await state.update { $0.selectedCategory = category }
        logDebug("Category selected: \(category?.name ?? "None")")
    }

    func onCategoryCreated(_ category: ___VARIABLE_categoryName___) async {
        logDebug("Category created: \(category.name)")
        await fetchCategories()
        await state.update { $0.selectedCategory = category }
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.isShowCategoryPicker = false
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
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
            logError("Cannot save ___VARIABLE_modelVariableName___, form is empty")
            return
        }
        await state.update { $0.isSaving = true }

        if await state.source == nil {
            do {
                let product = try await create___VARIABLE_modelName___()
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
            if let product = await update___VARIABLE_modelName___() {
                output?.onSave?(product)
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchCategories() async {
        do {
            let categories = try await ___VARIABLE_categoryVariableName___StorageService.fetch()
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
            let ___VARIABLE_modelVariableName___ = try await fetch___VARIABLE_modelName___()
            await state.update { viewState in
                viewState.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                viewState.setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        } catch {
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    private func fetch___VARIABLE_modelName___() async throws -> ___VARIABLE_modelName___ {
        try await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
    }

    func create___VARIABLE_modelName___() async throws -> ___VARIABLE_modelName___ {
        try await ___VARIABLE_modelVariableName___StorageService.save(
            name: state.name,
            color: state.color,
            date: state.date ?? Date(),
            imageData: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            categoryId: state.selectedCategory?.id
        )
    }

    func update___VARIABLE_modelName___() async -> ___VARIABLE_modelName___? {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
            logError("Cannot update ___VARIABLE_modelName___ - no product loaded")
            await state.update { $0.hud = .destructive("Failed to load product data") }
            return nil
        }
        do {
            let updatedProduct = try await ___VARIABLE_modelVariableName___StorageService.update(
                ___VARIABLE_modelVariableName___,
                name: state.name,
                color: state.color,
                date: state.date ?? Date(),
                image: state.image?.jpegData(compressionQuality: 0.5),
                note: state.note.isEmpty ? nil : state.note
            )

            let finalProduct = try await ___VARIABLE_modelVariableName___StorageService.updateCategory(
                updatedProduct,
                categoryId: state.selectedCategory?.id
            )
            return finalProduct
        } catch {
            logError("Failed to update ___VARIABLE_modelName___:", error: error)
            await state.update { $0.hud = .destructive("Failed to update product") }
            return nil
        }
    }
}