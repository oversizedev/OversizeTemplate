//___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

public extension ___VARIABLE_categoryName___DetailViewModel {
    enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapEdit
        case onTapDelete
        case onToggleFavorite
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
        case .onRefresh:
            await onRefresh()
        case .onTapDelete:
            await delete___VARIABLE_categoryName___()
        case .onTapEdit:
            await onEdit()
        case .onToggleFavorite:
            await toggleFavorite()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___DetailViewModel {
    func onAppear() async {
        if await state.___VARIABLE_categoryVariableName___State.successResult == nil {
            await fetchData()
        } else {
            await incrementViewCount()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onEdit() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        await state.set(\.destination, ___VARIABLE_categoryName___Destinations.edit(___VARIABLE_categoryVariableName___))
    }

    func delete___VARIABLE_categoryName___() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        do {
            try await ___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
            await state.set(\.isDismissed, true)
            await state.showHUD(.success("___VARIABLE_categoryName___ deleted"))
        } catch {
            await state.showAlert(.init(title: "Error", message: error.localizedDescription))
        }
    }

    func toggleFavorite() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        do {
            let updated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
                id: ___VARIABLE_categoryVariableName___.id,
                imageData: ___VARIABLE_categoryVariableName___.imageData,
                name: ___VARIABLE_categoryVariableName___.name,
                emoji: ___VARIABLE_categoryVariableName___.emoji,
                color: ___VARIABLE_categoryVariableName___.color,
                date: ___VARIABLE_categoryVariableName___.date,
                note: ___VARIABLE_categoryVariableName___.note,
                isFavorite: !___VARIABLE_categoryVariableName___.isFavorite,
                viewCount: ___VARIABLE_categoryVariableName___.viewCount,
                index: ___VARIABLE_categoryVariableName___.index
            )
            
            try await ___VARIABLE_categoryVariableName___StorageService.update(updated___VARIABLE_categoryName___)
            await state.set(\.___VARIABLE_categoryVariableName___State, .result(updated___VARIABLE_categoryName___))
            
            let message = updated___VARIABLE_categoryName___.isFavorite ? "Added to favorites" : "Removed from favorites"
            await state.showHUD(.success(message))
        } catch {
            await state.showAlert(.init(title: "Error", message: error.localizedDescription))
        }
    }
}

// MARK: - Private Methods

private extension ___VARIABLE_categoryName___DetailViewModel {
    func fetchData() async {
        await state.set(\.___VARIABLE_categoryVariableName___State, .loading)
        
        do {
            let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.getById(await state.___VARIABLE_categoryVariableName___Id)
            await state.set(\.___VARIABLE_categoryVariableName___State, .result(___VARIABLE_categoryVariableName___))
        } catch {
            await state.set(\.___VARIABLE_categoryVariableName___State, .error(error))
        }
    }

    func incrementViewCount() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        
        let updated___VARIABLE_categoryName___ = ___VARIABLE_categoryName___(
            id: ___VARIABLE_categoryVariableName___.id,
            imageData: ___VARIABLE_categoryVariableName___.imageData,
            name: ___VARIABLE_categoryVariableName___.name,
            emoji: ___VARIABLE_categoryVariableName___.emoji,
            color: ___VARIABLE_categoryVariableName___.color,
            date: ___VARIABLE_categoryVariableName___.date,
            note: ___VARIABLE_categoryVariableName___.note,
            isFavorite: ___VARIABLE_categoryVariableName___.isFavorite,
            viewCount: ___VARIABLE_categoryVariableName___.viewCount + 1,
            index: ___VARIABLE_categoryVariableName___.index
        )
        
        do {
            try await ___VARIABLE_categoryVariableName___StorageService.update(updated___VARIABLE_categoryName___)
            await state.set(\.___VARIABLE_categoryVariableName___State, .result(updated___VARIABLE_categoryName___))
        } catch {
            // Silently fail for view count updates
        }
    }
}