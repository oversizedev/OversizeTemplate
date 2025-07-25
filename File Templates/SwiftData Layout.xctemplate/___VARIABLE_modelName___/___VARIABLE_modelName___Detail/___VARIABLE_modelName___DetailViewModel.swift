// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
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
        case onTapToggleFavorite
        case onTapToggleArchive
    }
}

public actor ___VARIABLE_modelName___DetailViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var storageService

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
        case .onTapToggleFavorite:
            await toggleFavorite()
        case .onTapToggleArchive:
            await toggleArchive()
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
            $0.destination = .___VARIABLE_modelVariableName___Edit(id: $0.___VARIABLE_modelVariableName___Id)
        }
    }

    private func delete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else { return }
        
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    await self.performDelete(___VARIABLE_modelVariableName___)
                }
            }
        }
    }

    private func performDelete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await storageService.delete(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
            await state.update {
                $0.isDismissed = true
            }
        case .failure(let error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    private func toggleFavorite() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else { return }
        
        let result = await storageService.toggleFavorite(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await fetchData(force: true)
        case .failure(let error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    private func toggleArchive() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.result else { return }
        
        let result = await storageService.toggleArchive(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await fetchData(force: true)
        case .failure(let error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData(force _: Bool = false) async {
        await state.update {
            $0.___VARIABLE_modelVariableName___State = .loading
        }

        let id = await state.___VARIABLE_modelVariableName___Id
        let result = await storageService.fetch___VARIABLE_modelName___(id: id)
        
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
}
