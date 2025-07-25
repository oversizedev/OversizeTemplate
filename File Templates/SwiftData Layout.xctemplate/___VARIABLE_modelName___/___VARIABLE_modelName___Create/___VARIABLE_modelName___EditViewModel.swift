// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___EditViewModel {
    public enum Action: Sendable {
        case onAppear
        case onTapSave
        case onTapCancel
        case onFocusField(___VARIABLE_modelName___EditViewState.FocusField?)
        case onImageSelected(Data?)
        case onValidateForm
        case onResetForm
    }
}

public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var storageService

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
        case .onTapCancel:
            await onCancel()
        case let .onFocusField(field):
            await onFocusField(field)
        case let .onImageSelected(imageData):
            await onImageSelected(imageData)
        case .onValidateForm:
            await onValidateForm()
        case .onResetForm:
            await onResetForm()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewModel {
    func onAppear() async {
        switch await state.mode {
        case .editId:
            await fetchData()
        case .edit, .create:
            break
        }
        await onFocusField(.name)
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
        await state.update {
            $0.focusedField = field
        }
    }
    
    func onImageSelected(_ imageData: Data?) async {
        await state.update {
            #if os(macOS)
            if let imageData {
                $0.image = NSImage(data: imageData)
            } else {
                $0.image = nil
            }
            #else
            if let imageData {
                $0.image = UIImage(data: imageData)
            } else {
                $0.image = nil
            }
            #endif
        }
    }
    
    func onValidateForm() async {
        // Perform additional validation if needed
    }
    
    func onResetForm() async {
        await state.update {
            $0.resetForm()
        }
    }
    
    func onCancel() async {
        await state.update {
            $0.isDismissed = true
        }
    }

    func onSave() async {
        
        let result: Result<___VARIABLE_modelName___, AppError>
        
        switch await state.mode {
        case .create:
            result = await create___VARIABLE_modelName___()
        case .edit(let ___VARIABLE_modelVariableName___):
            result = await update___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case .editId:
            guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else {
                // Handle error case
                return
            }
            result = await update___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        }
        
        switch result {
        case .success(let ___VARIABLE_modelVariableName___):
            await state.update {
                $0.isDismissed = true
            }
        case .failure(let error):
            // Handle error case
        }
    }
}

// MARK: - Data Operations

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
        await state.update { $0.___VARIABLE_modelVariableName___State = .loading }
        
        let result = await fetch___VARIABLE_modelName___()
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

    func fetch___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        do {
            let result = await storageService.fetch___VARIABLE_modelName___(id: await state.___VARIABLE_modelVariableName___Id)
            return result
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        let currentState = await state
        
        let result = await storageService.add___VARIABLE_modelName___(
            id: currentState.___VARIABLE_modelVariableName___Id,
            name: currentState.name,
            color: currentState.color,
            date: currentState.date,
            image: currentState.imageData,
            note: currentState.note.isEmpty ? nil : currentState.note
        )
        
        return result
    }
    
    func update___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async -> Result<___VARIABLE_modelName___, AppError> {
        let currentState = await state
        
        await storageService.update___VARIABLE_modelName___(
            ___VARIABLE_modelVariableName___,
            name: currentState.name,
            color: currentState.color,
            date: currentState.date,
            image: currentState.imageData,
            note: currentState.note.isEmpty ? nil : currentState.note,
            isFavorite: currentState.isFavorite,
            isArchive: currentState.isArchive
        )
        
        return .success(___VARIABLE_modelVariableName___)
    }
}
