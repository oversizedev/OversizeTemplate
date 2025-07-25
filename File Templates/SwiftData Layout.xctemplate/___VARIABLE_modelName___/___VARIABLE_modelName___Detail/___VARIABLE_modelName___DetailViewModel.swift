// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension ___VARIABLE_modelName___DetailViewModel {
    public enum InputEvent: Sendable {
        case onAppear
        case onRefresh
        case onTapEdit___VARIABLE_modelName___
        case onTapDelete___VARIABLE_modelName___
        case onToggleFavorite
        case onToggleArchive
        case onShare
        case onIncrementViewCount
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

    public func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapDelete___VARIABLE_modelName___:
            await delete___VARIABLE_modelName___()
        case .onTapEdit___VARIABLE_modelName___:
            await onEdit()
        case .onToggleFavorite:
            await onToggleFavorite()
        case .onToggleArchive:
            await onToggleArchive()
        case .onShare:
            await onShare()
        case .onIncrementViewCount:
            await onIncrementViewCount()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewModel {
    func onAppear() async {
        if await state.___VARIABLE_modelVariableName___State.result == nil {
            await fetchData()
        }
        // Increment view count when detail is viewed
        await onIncrementViewCount()
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onEdit() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___ else { return }
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }
    
    func onToggleFavorite() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___ else { return }
        await updateFavoriteStatus(___VARIABLE_modelVariableName___, isFavorite: !___VARIABLE_modelVariableName___.isFavorite)
    }
    
    func onToggleArchive() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___ else { return }
        await updateArchiveStatus(___VARIABLE_modelVariableName___, isArchive: !___VARIABLE_modelVariableName___.isArchive)
    }
    
    func onShare() async {
        // Share functionality can be implemented here
    }
    
    func onIncrementViewCount() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___ else { return }
        await storageService.incrementViewCount(___VARIABLE_modelVariableName___)
        // Refresh to show updated view count
        await fetchData()
    }

    private func delete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    await self.performDelete(___VARIABLE_modelVariableName___)
                }
            }
        }
    }
    
    private func performDelete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        await state.update { viewState in
            viewState.isDismissed = true
        }
    }
    
    private func updateFavoriteStatus(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, isFavorite: Bool) async {
        await storageService.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___, isFavorite: isFavorite)
        await fetchData(force: true)
    }
    
    private func updateArchiveStatus(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, isArchive: Bool) async {
        await storageService.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___, isArchive: isArchive)
        await fetchData(force: true)
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData(force: Bool = false) async {
        await state.update { $0.___VARIABLE_modelVariableName___State = .loading }
        
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
        do {
            let result = await storageService.fetch___VARIABLE_modelName___(id: await state.___VARIABLE_modelVariableName___Id)
            return result
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
}
