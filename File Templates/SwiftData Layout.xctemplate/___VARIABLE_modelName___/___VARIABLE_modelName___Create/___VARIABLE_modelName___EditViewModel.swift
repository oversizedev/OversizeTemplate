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

    func onSave() async {
        guard await state.isValidForm else {
            return
        }
        
        await state.update {
            $0.isSaving = true
        }
        
        let result: Result<___VARIABLE_modelName___, AppError>
        
        switch await state.mode {
        case .create:
            result = await create___VARIABLE_modelName___()
        case .edit, .editId:
            result = await update___VARIABLE_modelName___()
        }
        
        await state.update {
            $0.isSaving = false
        }
        
        switch result {
        case .success:
            await state.update {
                $0.isDismissed = true
            }
        case .failure(let error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___EditViewModel {
    func fetchData() async {
        await state.update {
            $0.___VARIABLE_modelVariableName___State = .loading
        }

        let id = await state.___VARIABLE_modelVariableName___Id
        let result = await storageService.fetch___VARIABLE_modelName___(id: id)
        
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
                $0.setFields(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        case let .failure(error):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .error(error)
                $0.alert = .error(error)
            }
        }
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        let name = await state.name
        let note = await state.note.isEmpty ? nil : await state.note
        let color = await state.color
        let date = await state.date
        let isFavorite = await state.isFavorite
        let isArchive = await state.isArchive
        let id = await state.___VARIABLE_modelVariableName___Id
        
        let imageData: Data?
        #if os(macOS)
        if let image = await state.image {
            imageData = image.tiffRepresentation
        } else {
            imageData = nil
        }
        #else
        if let image = await state.image {
            imageData = image.pngData()
        } else {
            imageData = nil
        }
        #endif
        
        let result = await storageService.add___VARIABLE_modelName___(
            id: id,
            name: name,
            color: color,
            date: date,
            image: imageData,
            note: note
        )
        
        switch result {
        case .success(let ___VARIABLE_modelVariableName___):
            // Update favorite and archive status if needed
            if isFavorite || isArchive {
                let updateResult = await storageService.update___VARIABLE_modelName___(
                    ___VARIABLE_modelName___: ___VARIABLE_modelVariableName___,
                    isFavorite: isFavorite,
                    isArchive: isArchive
                )
                switch updateResult {
                case .success:
                    return .success(___VARIABLE_modelVariableName___)
                case .failure(let error):
                    return .failure(error)
                }
            }
            return .success(___VARIABLE_modelVariableName___)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func update___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else {
            return .failure(AppError.coreData(type: .fetchItems))
        }
        
        let name = await state.name
        let note = await state.note.isEmpty ? nil : await state.note
        let color = await state.color
        let date = await state.date
        let isFavorite = await state.isFavorite
        let isArchive = await state.isArchive
        
        let imageData: Data?
        #if os(macOS)
        if let image = await state.image {
            imageData = image.tiffRepresentation
        } else {
            imageData = nil
        }
        #else
        if let image = await state.image {
            imageData = image.pngData()
        } else {
            imageData = nil
        }
        #endif
        
        let result = await storageService.update___VARIABLE_modelName___(
            ___VARIABLE_modelName___: ___VARIABLE_modelVariableName___,
            name: name,
            color: color,
            date: date,
            image: imageData,
            note: note,
            isFavorite: isFavorite,
            isArchive: isArchive
        )
        
        switch result {
        case .success:
            return .success(___VARIABLE_modelVariableName___)
        case .failure(let error):
            return .failure(error)
        }
    }
}
