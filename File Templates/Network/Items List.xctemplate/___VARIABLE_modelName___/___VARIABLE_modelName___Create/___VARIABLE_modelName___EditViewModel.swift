// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Edit.self)
public actor ___VARIABLE_modelName___EditViewModel: ViewModelProtocol {}

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
            break
        case .failure:
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
