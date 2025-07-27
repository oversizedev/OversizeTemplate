//___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

public extension ___VARIABLE_modelName___DetailViewModel {
    enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapEdit___VARIABLE_modelName___
        case onTapDelete___VARIABLE_modelName___
        case onToggleFavorite
        case onToggleArchive
    }
}

public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService

    /// ViewState
    public var state: ___VARIABLE_modelName___DetailViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___DetailViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapDelete___VARIABLE_modelName___:
            await delete___VARIABLE_modelName___()
        case .onTapEdit___VARIABLE_modelName___:
            await onEdit()
        case .onToggleFavorite:
            await toggleFavorite()
        case .onToggleArchive:
            await toggleArchive()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewModel {
    func onAppear() async {
        if await state.___VARIABLE_modelVariableName___State.successResult == nil {
            await fetchData()
        } else {
            await incrementViewCount()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onEdit() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        logSuccess("___VARIABLE_modelName___ edit completed")
                        await self.fetchData()
                    }
                }
            }))
        }
    }

    private func delete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    logData("Attempting to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
                    let result = await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                    switch result {
                    case .success:
                        logDeleted("___VARIABLE_modelName___")
                        await self.onDeleteSuccess()
                    case let .failure(error):
                        logError("Failed to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)", error: error)
                        await self.onDeleteFailure(error)
                    }
                }
            }
        }
    }

    private func onDeleteSuccess() async {
        await state.update { viewState in
            viewState.hud = .delete
            viewState.isDismissed = true
        }
    }

    private func onDeleteFailure(_ error: Error) async {
        await state.update { $0.alert = .error(error) }
    }

    private func toggleFavorite() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
            logWarning("Cannot toggle favorite - no ___VARIABLE_modelName___ loaded")
            return
        }
        let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite

        let result = await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func toggleArchive() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
            logWarning("Cannot toggle archive - no ___VARIABLE_modelName___ loaded")
            return
        }
        let wasArchived = ___VARIABLE_modelVariableName___.isArchive

        let result = await ___VARIABLE_modelVariableName___StorageService.toggleArchive(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await state.update { viewState in
                viewState.hud = wasArchived ? .unarchive() : .archive()
                viewState.isDismissed = true
            }
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func incrementViewCount() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
        _ = await ___VARIABLE_modelVariableName___StorageService.incrementViewCount(___VARIABLE_modelVariableName___)
    }
}

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData() async {
        await fetch___VARIABLE_modelName___()
    }
}

private extension ___VARIABLE_modelName___DetailViewModel {
    func fetch___VARIABLE_modelName___() async {
        let result = await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            await state.update { $0.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___) }
        case let .failure(error):
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }
}
