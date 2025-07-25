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
        case onFocusField(___VARIABLE_modelName___EditViewState.FocusField?)
    }
}

public actor ___VARIABLE_modelName___EditViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var storageService

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
        case let .onFocusField(field):
            await onFocusField(field)
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___EditViewModel {
    func onAppear() async {
        if await state.___VARIABLE_modelVariableName___State.result == nil {
            await fetchData()
        }
        await onFocusField(.name)
    }

    func onFocusField(_ field: ___VARIABLE_modelName___EditViewState.FocusField?) async {
        await state.update {
            $0.focusedField = field
        }
    }

    func onSave() async {
        guard await !state.isEmptyForm else {
            return
        }
        await state.update {
            $0.isSaving = true
        }
        
        let result: Result<___VARIABLE_modelName___, AppError>
        
        switch await state.mode {
        case .create:
            result = await create___VARIABLE_modelName___()
        case .edit(let ___VARIABLE_modelVariableName___), .editId:
            if case .edit(let ___VARIABLE_modelVariableName___) = await state.mode {
                result = await update___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
            } else if let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result {
                result = await update___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
            } else {
                result = .failure(AppError.coreData(type: .fetchItems))
            }
        }
        
        switch result {
        case .success:
            // Handle success - navigate back, show success message
            await state.update {
                $0.isSaving = false
                // TODO: Add navigation back logic
            }
        case .failure:
            // Handle error
            await state.update {
                $0.isSaving = false
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
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
        await storageService.fetch___VARIABLE_modelName___(id: await state.___VARIABLE_modelVariableName___Id)
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        let imageData: Data?
        #if os(macOS)
        imageData = await state.image?.tiffRepresentation
        #else
        imageData = await state.image?.jpegData(compressionQuality: 0.8)
        #endif
        
        let result = await storageService.add___VARIABLE_modelName___(
            id: await state.___VARIABLE_modelVariableName___Id,
            name: await state.name,
            color: await state.color,
            date: await state.date ?? Date(),
            image: imageData,
            note: await state.note.isEmpty ? nil : await state.note
        )
        
        return result
    }

    func update___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async -> Result<___VARIABLE_modelName___, AppError> {
        let imageData: Data?
        #if os(macOS)
        imageData = await state.image?.tiffRepresentation
        #else
        imageData = await state.image?.jpegData(compressionQuality: 0.8)
        #endif
        
        await storageService.update___VARIABLE_modelName___(
            ___VARIABLE_modelName___: ___VARIABLE_modelVariableName___,
            name: await state.name,
            color: await state.color,
            date: await state.date,
            image: imageData,
            note: await state.note.isEmpty ? nil : await state.note
        )
        
        return .success(___VARIABLE_modelVariableName___)
    }
}
