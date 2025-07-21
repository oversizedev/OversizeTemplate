// ___FILEHEADER___

import Database
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
        
        let result = await create___VARIABLE_modelName___()
        switch result {
        case .success:
            // Handle success - navigate back, show success message
            break
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
        .failure(AppError.network(type: .unknown))
    }
    
    func create___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}
