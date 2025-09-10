// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

public extension ___VARIABLE_modelName___EditViewModel {
    enum Action: Sendable {
        case onAppear
        case onTapSave
        case onFocusField(___VARIABLE_modelName___EditViewState.FocusField?)
        case onNameChanged(String)
        case onNoteChanged(String)
        case onUrlChanged(URL?)
        case on___VARIABLE_categoryName___Changed(___VARIABLE_categoryName___?)
    }
}

public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_modelName___EditViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___EditViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onTapSave:
            await onSave()
        case let .onFocusField(field):
            await onFocusField(field)
        case let .onNameChanged(name):
            await onNameChanged(name: name)
        case let .onNoteChanged(note):
            await onNoteChanged(note: note)
        case let .onUrlChanged(url):
            await onUrlChanged(url: url)
        case let .on___VARIABLE_categoryName___Changed(___VARIABLE_categoryVariableName___):
            await on___VARIABLE_categoryName___Changed(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___)
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewModel {
    func onAppear() async {
        await fetch___VARIABLE_categoryPluralVariableName___()
        switch state.mode {
        case .edit, .editId:
            await fetchData()
        default:
            break
        }
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
        await state.update { $0.focusedField = field }
    }

    func onNameChanged(name: String) async {
        await updateFormValidation()
    }

    func onNoteChanged(note: String) async {
        await updateFormValidation()
    }

    func onUrlChanged(url: URL?) async {
        await updateFormValidation()
    }

    func on___VARIABLE_categoryName___Changed(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        await state.update { $0.selected___VARIABLE_categoryName___ = ___VARIABLE_categoryVariableName___ }
        await updateFormValidation()
    }

    func updateFormValidation() async {
        await state.update { viewState in
            viewState.isEmptyForm = viewState.name.isEmpty && viewState.note.isEmpty
            viewState.isValidForm = !viewState.name.isEmpty
        }
        await logDebug("Form validation changed - valid: \(state.isValidForm)")
    }

    func onSave() async {
        guard await !state.isEmptyForm else {
            logError("Cannot save ___VARIABLE_modelVariableName___, form is empty")
            return
        }
        await state.update { $0.isSaving = true }

        switch state.mode {
        case .create:
            let result = await create___VARIABLE_modelName___()
            switch result {
            case .success:
                await state.update { viewState in
                    viewState.hud = .success
                    viewState.isSaving = false
                    viewState.isDismissed = true
                    viewState.handler(.save)
                }
            case .failure:
                await state.update { $0.isSaving = false }
            }

        case .edit, .editId:
            await state.update {
                $0.hud = .success
                $0.isSaving = false
                $0.isDismissed = true
            }
            await update___VARIABLE_modelName___()
            await state.update {
                $0.handler(.save)
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
        let result = await fetch___VARIABLE_modelName___Internal()
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update { viewState in
                viewState.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                viewState.setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        case let .failure(error):
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    func fetch___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, Error> {
        await fetch___VARIABLE_modelName___Internal()
    }

    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, Error> {
        await ___VARIABLE_modelVariableName___StorageService.save(
            name: state.name,
            color: state.color,
            date: state.date ?? Date(),
            image: state.image?.jpegData(compressionQuality: 5),
            note: state.note.isEmpty ? nil : state.note,
            ___VARIABLE_categoryVariableName___: state.selected___VARIABLE_categoryName___
        )
    }

    func update___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
            logError("Cannot update ___VARIABLE_modelName___ - no product loaded")
            return
        }
        await ___VARIABLE_modelVariableName___StorageService.update(
            ___VARIABLE_modelVariableName___,
            name: state.name,
            color: state.color,
            date: state.date ?? Date(),
            image: state.image?.jpegData(compressionQuality: 5),
            note: state.note.isEmpty ? nil : state.note,
            ___VARIABLE_categoryVariableName___: state.selected___VARIABLE_categoryName___
        )
    }

    func fetch___VARIABLE_categoryPluralVariableName___() async {
        let result = await ___VARIABLE_categoryVariableName___StorageService.fetchAll()
        switch result {
        case let .success(___VARIABLE_categoryPluralVariableName___):
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___) }
        case let .failure(error):
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
        }
    }

    private func fetch___VARIABLE_modelName___Internal() async -> Result<___VARIABLE_modelName___, Error> {
        await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
    }
}
