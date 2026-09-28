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

    private var saveTask: Task<Void, Never>?

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
        await state.update { $0.selected___VARIABLE_categoryName___Id = ___VARIABLE_categoryVariableName___?.id }
        await updateFormValidation()
        Log.debug("___VARIABLE_categoryName___ selected: \(___VARIABLE_categoryVariableName___?.name ?? "None")")
    }

    func on___VARIABLE_categoryName___Created(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        Log.debug("___VARIABLE_categoryName___ created: \(___VARIABLE_categoryVariableName___.name)")
        await fetch___VARIABLE_categoryPluralVariableName___()
        await state.update { $0.selected___VARIABLE_categoryName___Id = ___VARIABLE_categoryVariableName___.id }
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
            viewState.isEmptyForm = viewState.trimmedName.isEmpty && viewState.note.isEmpty
            viewState.isValidForm = !viewState.trimmedName.isEmpty
        }
        await Log.debug("Form validation changed - valid: \(state.isValidForm)")
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
                let ___VARIABLE_modelVariableName___ = if await state.source == nil {
                    try await create___VARIABLE_modelName___()
                } else {
                    try await update___VARIABLE_modelName___()
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

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetch___VARIABLE_categoryPluralVariableName___() async {
        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch()
            await state.update { viewState in
                viewState.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___)
                if let categoryId = viewState.selected___VARIABLE_categoryName___Id,
                   !___VARIABLE_categoryPluralVariableName___.contains(where: { $0.id == categoryId })
                {
                    viewState.selected___VARIABLE_categoryName___Id = nil
                }
            }
        } catch {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
            Log.error("Failed to fetch ___VARIABLE_categoryPluralVariableName___:", error: error)
        }
    }

    func fetchData() async {
        do {
            let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
            await state.update { viewState in
                viewState.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                viewState.name = ___VARIABLE_modelVariableName___.name
                viewState.note = ___VARIABLE_modelVariableName___.note ?? ""
                viewState.color = ___VARIABLE_modelVariableName___.color
                viewState.date = ___VARIABLE_modelVariableName___.date
                #if os(macOS)
                    viewState.image = ___VARIABLE_modelVariableName___.imageData.flatMap { NSImage(data: $0) }
                #else
                    viewState.image = ___VARIABLE_modelVariableName___.imageData.flatMap { UIImage(data: $0) }
                #endif
                viewState.originalImage = viewState.image
                viewState.selected___VARIABLE_categoryName___Id = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___Id
            }
            await updateFormValidation()
        } catch {
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    func create___VARIABLE_modelName___() async throws -> ___VARIABLE_modelName___ {
        try await ___VARIABLE_modelVariableName___StorageService.save(
            name: state.trimmedName,
            color: state.color,
            date: state.date ?? Date(),
            imageData: state.image?.jpegData(compressionQuality: 0.5),
            note: state.note.isEmpty ? nil : state.note,
            ___VARIABLE_categoryVariableName___Id: state.selected___VARIABLE_categoryName___Id
        )
    }

    func update___VARIABLE_modelName___() async throws -> ___VARIABLE_modelName___ {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else {
            Log.error("Cannot update ___VARIABLE_modelName___ - no ___VARIABLE_modelVariableName___ loaded")
            throw PersistenceError.itemNotFound
        }
        let image: Data?? = await state.isImageChanged
            ? .some(state.image?.jpegData(compressionQuality: 0.5))
            : .none
        return try await ___VARIABLE_modelVariableName___StorageService.update(
            ___VARIABLE_modelVariableName___,
            name: state.trimmedName,
            color: state.color,
            date: state.date ?? Date(),
            image: image,
            note: .some(state.note.isEmpty ? nil : state.note),
            categoryId: .some(state.selected___VARIABLE_categoryName___Id)
        )
    }
}
