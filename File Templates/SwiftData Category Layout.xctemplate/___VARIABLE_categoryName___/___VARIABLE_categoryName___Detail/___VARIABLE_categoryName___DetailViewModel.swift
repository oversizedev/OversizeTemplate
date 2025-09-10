// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

public extension ___VARIABLE_categoryName___DetailViewModel {
    enum Action: Sendable {
        case onAppear
        case onEdit
        case onDelete
        case onDuplicate
        case onToggleFavorite
        case onToggleArchive
    }
}

public actor ___VARIABLE_categoryName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_categoryName___DetailViewState

    /// Initialization
    public init(state: ___VARIABLE_categoryName___DetailViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onEdit:
            await onEdit()
        case .onDelete:
            await onDelete()
        case .onDuplicate:
            await onDuplicate()
        case .onToggleFavorite:
            await onToggleFavorite()
        case .onToggleArchive:
            await onToggleArchive()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___DetailViewModel {
    func onAppear() async {
        await fetch___VARIABLE_categoryName___()
    }

    func onEdit() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        await state.update {
            $0.destination = .___VARIABLE_categoryVariableName___Edit(___VARIABLE_categoryVariableName___, callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        await self.fetch___VARIABLE_categoryName___()
                    }
                }
            }))
        }
    }

    func onDelete() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    let result = await self.___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
                    switch result {
                    case .success:
                        await self.state.update { $0.isDismissed = true }
                    case let .failure(error):
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onDuplicate() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        let result = await ___VARIABLE_categoryVariableName___StorageService.duplicate(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = .success("Duplicated") }
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    func onToggleFavorite() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        let wasFavorite = ___VARIABLE_categoryVariableName___.isFavorite
        let result = await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetch___VARIABLE_categoryName___()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    func onToggleArchive() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        let wasArchived = ___VARIABLE_categoryVariableName___.isArchive
        let result = await ___VARIABLE_categoryVariableName___StorageService.toggleArchive(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasArchived ? .unarchive() : .archive() }
            await fetch___VARIABLE_categoryName___()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func fetch___VARIABLE_categoryName___() async {
        let ___VARIABLE_categoryVariableName___Id = await state.___VARIABLE_categoryVariableName___Id
        let result = await ___VARIABLE_categoryVariableName___StorageService.fetch(id: ___VARIABLE_categoryVariableName___Id)
        switch result {
        case let .success(___VARIABLE_categoryVariableName___):
            await state.update { $0.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___) }
        case let .failure(error):
            await state.update { $0.___VARIABLE_categoryVariableName___State = .error(error) }
        }
    }
}