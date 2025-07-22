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
        case onTapEdit
        case onTapDelete
        case onTapDuplicate
        case onTapToggleFavorite
        case onTapToggleArchive
        case onConfirmDelete
    }
}

public actor ___VARIABLE_modelName___DetailViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) private var storageService: ___VARIABLE_modelName___StorageService

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
        case .onTapEdit:
            await onEdit()
        case .onTapDelete:
            await onDelete()
        case .onTapDuplicate:
            await onDuplicate()
        case .onTapToggleFavorite:
            await onToggleFavorite()
        case .onTapToggleArchive:
            await onToggleArchive()
        case .onConfirmDelete:
            await onConfirmDelete()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewModel {
    func onAppear() async {
        let resultState = await state.___VARIABLE_modelVariableName___State
        if resultState.result == nil {
            await fetchData()
        }
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onEdit() async {
        let canEdit = await state.canEdit
        guard canEdit else { return }
        
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit(id: $0.___VARIABLE_modelVariableName___Id) { [weak self] updated___VARIABLE_modelName___ in
                Task {
                    await self?.state.update {
                        $0.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___: updated___VARIABLE_modelName___)
                    }
                }
            }
        }
    }

    func onDelete() async {
        let canDelete = await state.canDelete
        guard canDelete else { return }
        
        await state.update {
            $0.showDeleteConfirmation()
        }
    }

    func onConfirmDelete() async {
        let itemState = await state.___VARIABLE_modelVariableName___State
        guard let ___VARIABLE_modelVariableName___ = itemState.result else { return }

        await state.update {
            $0.setProcessing(true)
            $0.hideDeleteConfirmation()
        }

        let result = await storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case .success:
            await state.update {
                $0.setProcessing(false)
                $0.dismissView()
            }
            logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
        case let .failure(error):
            await state.update {
                $0.setProcessing(false)
                $0.showError(error)
            }
        }
    }

    func onDuplicate() async {
        let itemState = await state.___VARIABLE_modelVariableName___State
        let canToggleActions = await state.canToggleActions
        guard let ___VARIABLE_modelVariableName___ = itemState.result,
              canToggleActions else { return }

        await state.update {
            $0.setProcessing(true)
        }

        let result = await storageService.duplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case let .success(duplicated___VARIABLE_modelName___):
            await state.update {
                $0.setProcessing(false)
                $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: duplicated___VARIABLE_modelName___)
            }
        case let .failure(error):
            await state.update {
                $0.setProcessing(false)
                $0.showError(error)
            }
        }
    }

    func onToggleFavorite() async {
        let itemState = await state.___VARIABLE_modelVariableName___State
        let canToggleActions = await state.canToggleActions
        guard let ___VARIABLE_modelVariableName___ = itemState.result,
              canToggleActions else { return }

        await state.update {
            $0.setProcessing(true)
        }

        let result = await storageService.toggleFavorite___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case let .success(updated___VARIABLE_modelName___):
            await state.update {
                $0.setProcessing(false)
                $0.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___: updated___VARIABLE_modelName___)
            }
        case let .failure(error):
            await state.update {
                $0.setProcessing(false)
                $0.showError(error)
            }
        }
    }

    func onToggleArchive() async {
        let itemState = await state.___VARIABLE_modelVariableName___State
        let canToggleActions = await state.canToggleActions
        guard let ___VARIABLE_modelVariableName___ = itemState.result,
              canToggleActions else { return }

        await state.update {
            $0.setProcessing(true)
        }

        let result = await storageService.toggleArchive___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case let .success(updated___VARIABLE_modelName___):
            await state.update {
                $0.setProcessing(false)
                $0.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___: updated___VARIABLE_modelName___)
            }
        case let .failure(error):
            await state.update {
                $0.setProcessing(false)
                $0.showError(error)
            }
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData(force: Bool = false) async {
        let itemStateIsIdle = await state.___VARIABLE_modelVariableName___State.isIdle
        if force || itemStateIsIdle {
            await state.update {
                $0.___VARIABLE_modelVariableName___State = .loading
            }
        }

        let ___VARIABLE_modelVariableName___Id = await state.___VARIABLE_modelVariableName___Id
        let result = await storageService.fetch___VARIABLE_modelName___(id: ___VARIABLE_modelVariableName___Id)
        
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
