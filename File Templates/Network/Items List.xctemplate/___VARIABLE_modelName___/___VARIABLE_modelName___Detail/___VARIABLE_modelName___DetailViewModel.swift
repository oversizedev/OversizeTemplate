// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Detail.self)
public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewModel {
    func onAppear() async {
        if await state.___VARIABLE_modelVariableName___State.result == nil {
            await fetchData()
        }
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onEdit() async {
        await state.update {
            $0.destination = .edit(id: $0.___VARIABLE_modelVariableName___Id)
        }
    }

    func delete___VARIABLE_modelName___() async {
        await state.update { viewState in
            viewState.alert = .delete {
                logDeleted("___VARIABLE_modelName___")
                viewState.isDismissed = true
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData(force _: Bool = false) async {
        let result = await fetch___VARIABLE_modelName___()
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
            }
        case let .failure(error):
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .error(error)
            }
        }
    }

    private func fetch___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}
