// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___EditViewModel {
    enum InputEvent {
        case onAppear
        case onTapSave
        case onTapDelete
        case onTapDuplicate
        case onTapReset
        case onTapCancel
        case onFocusField(___VARIABLE_modelName___EditViewState.FocusField?)
        case onValidateName
        case onValidateNote
        case onValidateDate
        case onValidateAll
        case onImageChanged
        case onConfirmDelete
        case onConfirmDiscard
    }
}

public actor ___VARIABLE_modelName___EditViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) private var storageService: ___VARIABLE_modelName___StorageService

    /// ViewState
    public var state: ___VARIABLE_modelName___EditViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___EditViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onTapSave:
            await onSave()
        case .onTapDelete:
            await onDelete()
        case .onTapDuplicate:
            await onDuplicate()
        case .onTapReset:
            await onReset()
        case .onTapCancel:
            await onCancel()
        case let .onFocusField(field):
            await onFocusField(field)
        case .onValidateName:
            await onValidateName()
        case .onValidateNote:
            await onValidateNote()
        case .onValidateDate:
            await onValidateDate()
        case .onValidateAll:
            await onValidateAll()
        case .onImageChanged:
            await onImageChanged()
        case .onConfirmDelete:
            await onConfirmDelete()
        case .onConfirmDiscard:
            await onConfirmDiscard()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewModel {
    func onAppear() async {
        switch await state.mode {
        case .editId:
            await fetchData()
        case .create, .edit:
            await onFocusField(.name)
        }
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
        await state.update {
            $0.focusedField = field
        }
    }

    func onValidateName() async {
        await state.update {
            $0.validateName()
        }
    }

    func onValidateNote() async {
        await state.update {
            $0.validateNote()
        }
    }

    func onValidateDate() async {
        await state.update {
            $0.validateDate()
        }
    }

    func onValidateAll() async {
        await state.update {
            $0.validateAll()
        }
    }

    func onImageChanged() async {
        // Validate image size if needed
        // Currently no validation required
    }

    func onSave() async {
        await onValidateAll()
        
        guard await state.isValidForm else {
            return
        }

        await state.update {
            $0.isSaving = true
        }

        let result = await save___VARIABLE_modelName___()
        
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update {
                $0.isSaving = false
                $0.triggerCallback(.saved(___VARIABLE_modelVariableName___))
            }
        case let .failure(error):
            await state.update {
                $0.isSaving = false
                $0.alert = .error(error)
            }
        }
    }

    func onDelete() async {
        await state.update {
            $0.isShowingDeleteConfirmation = true
        }
    }

    func onConfirmDelete() async {
        guard case let .edit(___VARIABLE_modelVariableName___) = await state.mode else { return }

        await state.update {
            $0.isDeleting = true
            $0.isShowingDeleteConfirmation = false
        }

        let result = await storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case .success:
            await state.update {
                $0.isDeleting = false
                $0.triggerCallback(.deleted(___VARIABLE_modelVariableName___))
            }
        case let .failure(error):
            await state.update {
                $0.isDeleting = false
                $0.alert = .error(error)
            }
        }
    }

    func onDuplicate() async {
        guard case let .edit(___VARIABLE_modelVariableName___) = await state.mode else { return }

        let result = await storageService.duplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case let .success(duplicated___VARIABLE_modelName___):
            await state.update {
                $0.triggerCallback(.saved(duplicated___VARIABLE_modelName___))
            }
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    func onReset() async {
        await state.update {
            switch $0.mode {
            case .create:
                $0.resetForm()
            case .edit:
                $0.resetToOriginal()
            case .editId:
                $0.resetForm()
            }
        }
    }

    func onCancel() async {
        let hasChanges = await state.hasChangedFromOriginal
        
        if hasChanges {
            await state.update {
                $0.isShowingDiscardConfirmation = true
            }
        } else {
            await state.update {
                $0.triggerCallback(.cancelled)
            }
        }
    }

    func onConfirmDiscard() async {
        await state.update {
            $0.isShowingDiscardConfirmation = false
            $0.triggerCallback(.cancelled)
        }
    }
}

// MARK: - Data Operations

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
        await state.update {
            $0.___VARIABLE_modelVariableName___State = .loading
        }

        let ___VARIABLE_modelVariableName___Id = await state.___VARIABLE_modelVariableName___Id
        let result = await storageService.fetch___VARIABLE_modelName___(id: ___VARIABLE_modelVariableName___Id)
        
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                $0.setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        case let .failure(error):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .error(error)
            }
        }
    }

    func save___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        let currentState = await state
        let mode = currentState.mode
        let ___VARIABLE_modelVariableName___Id = currentState.___VARIABLE_modelVariableName___Id
        let name = currentState.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let note = currentState.note.isEmpty ? nil : currentState.note
        let color = currentState.color
        let date = currentState.date
        let imageData = currentState.imageData

        switch mode {
        case .create:
            // Validate name uniqueness
            let validationResult = await storageService.validate___VARIABLE_modelName___(name: name)
            
            switch validationResult {
            case .success:
                return await storageService.add___VARIABLE_modelName___(
                    id: ___VARIABLE_modelVariableName___Id,
                    name: name,
                    color: color,
                    date: date,
                    image: imageData,
                    note: note
                )
            case .failure(let error):
                return .failure(error)
            }
            
        case .edit(let ___VARIABLE_modelVariableName___), .editId:
            // For edit mode, validate name uniqueness excluding current item
            let validationResult = await storageService.validate___VARIABLE_modelName___(
                name: name,
                excludingId: ___VARIABLE_modelVariableName___Id
            )
            
            switch validationResult {
            case .success:
                if case .edit(let existing___VARIABLE_modelName___) = mode {
                    return await storageService.update___VARIABLE_modelName___(
                        ___VARIABLE_modelVariableName___: existing___VARIABLE_modelName___,
                        name: name,
                        color: color,
                        date: date,
                        image: imageData,
                        note: note
                    )
                } else {
                    // For editId case, fetch the item first
                    let fetchResult = await storageService.fetch___VARIABLE_modelName___(id: ___VARIABLE_modelVariableName___Id)
                    switch fetchResult {
                    case .success(let ___VARIABLE_modelVariableName___):
                        return await storageService.update___VARIABLE_modelName___(
                            ___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___,
                            name: name,
                            color: color,
                            date: date,
                            image: imageData,
                            note: note
                        )
                    case .failure(let error):
                        return .failure(error)
                    }
                }
            case .failure(let error):
                return .failure(error)
            }
        }
    }
}
