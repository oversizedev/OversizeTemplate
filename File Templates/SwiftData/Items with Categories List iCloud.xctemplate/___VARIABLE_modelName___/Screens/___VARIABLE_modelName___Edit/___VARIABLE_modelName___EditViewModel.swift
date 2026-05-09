// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Edit.self)
public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetch___VARIABLE_categoryPluralVariableName___()

        if await state.source != nil {
            await fetchData()
        }
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
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

    func on___VARIABLE_categoryName___Selected(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        await state.update { $0.selected___VARIABLE_categoryName___ = ___VARIABLE_categoryVariableName___ }
        await updateFormValidation()
        logDebug("___VARIABLE_categoryName___ selected: \(___VARIABLE_categoryVariableName___?.name ?? "None")")
    }

    func on___VARIABLE_categoryName___Created(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        logDebug("___VARIABLE_categoryName___ created: \(___VARIABLE_categoryVariableName___.name)")
        await fetch___VARIABLE_categoryPluralVariableName___()
        await state.update { $0.selected___VARIABLE_categoryName___ = ___VARIABLE_categoryVariableName___ }
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.update { viewState in
            viewState.isShow___VARIABLE_categoryName___Picker = false
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { ___VARIABLE_categoryVariableName___ in
                    Task { await self.on___VARIABLE_categoryName___Created(___VARIABLE_categoryVariableName___) }
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
    func fetch___VARIABLE_categoryPluralVariableName___() async {
        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch()
            await state.update { viewState in
                viewState.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___)
                viewState.set___VARIABLE_categoryPluralVariableName___(___VARIABLE_categoryPluralVariableName___)
            }
        } catch {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
            logError("Failed to fetch ___VARIABLE_categoryPluralVariableName___:", error: error)
        }
    }

    func fetchData() async {
        do {
            let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
            await state.update { viewState in
                viewState.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                viewState.setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
            await updateFormValidation()
        } catch {
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    func create___VARIABLE_modelName___() async throws -> ___VARIABLE_modelName___ {
        try await ___VARIABLE_modelVariableName___StorageService.save(
            name: state.name,
            color: state.color,
            date: state.date ?? Date(),
            imageData: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            ___VARIABLE_categoryVariableName___Id: state.selected___VARIABLE_categoryName___?.id
        )
    }

    func update___VARIABLE_modelName___() async -> ___VARIABLE_modelName___? {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else {
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

            return try await ___VARIABLE_modelVariableName___StorageService.update___VARIABLE_categoryName___(
                updatedProduct,
                categoryId: state.selected___VARIABLE_categoryName___?.id
            )
        } catch {
            logError("Failed to update ___VARIABLE_modelName___:", error: error)
            await state.update { $0.hud = .destructive("Failed to update product") }
            return nil
        }
    }
}
