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
        
        let result = switch await state.mode {
        case .create:
            await create___VARIABLE_modelName___()
        case .edit, .editId:
            await update___VARIABLE_modelName___()
        }
        
        switch result {
        case .success:
            await state.update {
                $0.isSaving = false
            }
            // Navigate back or show success message
            logInfo("___VARIABLE_modelName___ saved successfully")
        case .failure:
            await state.update {
                $0.isSaving = false
            }
            logError("Failed to save ___VARIABLE_modelName___")
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
        switch await state.mode {
        case let .editId(id):
            await storageService.fetch___VARIABLE_modelName___(id: id)
        case let .edit(___VARIABLE_modelVariableName___):
            .success(___VARIABLE_modelVariableName___)
        case .create:
            .failure(AppError.coreData(type: .unknown))
        }
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        let imageData: Data?
        #if os(iOS)
        imageData = await state.image?.jpegData(compressionQuality: 0.8)
        #elseif os(macOS)
        imageData = await state.image?.tiffRepresentation
        #else
        imageData = nil
        #endif
        
        return await storageService.add___VARIABLE_modelName___(
            id: await state.___VARIABLE_modelVariableName___Id,
            name: await state.name,
            color: await state.color,
            date: await state.date ?? Date(),
            image: imageData,
            note: await state.note.isEmpty ? nil : await state.note
        )
    }
    
    func update___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else {
            return .failure(AppError.coreData(type: .unknown))
        }
        
        let imageData: Data?
        #if os(iOS)
        imageData = await state.image?.jpegData(compressionQuality: 0.8)
        #elseif os(macOS)
        imageData = await state.image?.tiffRepresentation
        #else
        imageData = nil
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
