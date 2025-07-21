// ___FILEHEADER___

import Database
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___DetailViewModel {
    enum InputEvent {
        case onAppear
        case onRefresh
        case onTapEdit___VARIABLE_modelName___
        case onTapDelete___VARIABLE_modelName___
    }
}

public actor ___VARIABLE_modelName___DetailViewModel {
    /// ViewState
    public var state: ___VARIABLE_modelName___DetailViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___DetailViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapDelete___VARIABLE_modelName___:
            await delete___VARIABLE_modelName___()
        case .onTapEdit___VARIABLE_modelName___:
            await onEdit()
        }
    }
}

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
            $0.destination = .mealProductEdit(id: $0.___VARIABLE_modelVariableName___Id)
        }
    }

    private func delete___VARIABLE_modelName___() async {
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
