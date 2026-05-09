//___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

public extension ___VARIABLE_modelName___ListViewModel {
    enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreate___VARIABLE_modelName___
        case onTapDetail___VARIABLE_modelName___(___VARIABLE_modelName___)
        case onTapEdit___VARIABLE_modelName___(___VARIABLE_modelName___)
        case onTapDelete___VARIABLE_modelName___(___VARIABLE_modelName___)
        case onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelName___)
        case onToggleFavorite(___VARIABLE_modelName___)
        case onToggleArchive(___VARIABLE_modelName___)
        case onTapDisplayType(___VARIABLE_modelName___ListDisplayType)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onChangeSortType(___VARIABLE_modelName___SortType)
        case onChangeSortOrder(___VARIABLE_modelName___SortOrder)
        case onChangeFilterType(___VARIABLE_modelName___FilterType)
        case onTapArchive___VARIABLE_modelName___s
        case onToggleCompactView
        case onChangeViewOption(___VARIABLE_modelName___ViewOption)
    }
}

public actor ___VARIABLE_modelName___ListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService

    /// ViewState
    public var state: ___VARIABLE_modelName___ListViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___ListViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapSearch:
            await onTapSearch()
        case let .onChangeSearchTerm(oldValue: oldValue, newValue: newValue):
            await onChangeSearchTerm(oldValue: oldValue, newValue: newValue)
        case let .onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await duplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onToggleFavorite(___VARIABLE_modelVariableName___):
            await toggleFavorite(___VARIABLE_modelVariableName___)
        case let .onToggleArchive(___VARIABLE_modelVariableName___):
            await toggleArchive(___VARIABLE_modelVariableName___)
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case .onTapCreate___VARIABLE_modelName___:
            await onCreate()
        case let .onChangeSortType(sortType):
            await onChangeSortType(sortType)
        case let .onChangeSortOrder(sortOrder):
            await onChangeSortOrder(sortOrder)
        case let .onChangeFilterType(filterType):
            await onChangeFilterType(filterType)
        case .onTapArchive___VARIABLE_modelName___s:
            await onTapArchive___VARIABLE_modelName___s()
        case .onToggleCompactView:
            await onToggleCompactView()
        case let .onChangeViewOption(viewOption):
            await onChangeViewOption(viewOption)
        case let .onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewModel {
    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(oldValue: String, newValue: String) async {
        await state.update { $0.searchTerm = newValue }
        await fetchData(searchTerm: newValue)
    }

    func onTapSearch() async {
        await state.update { $0.isSearch.toggle() }
    }

    func onCreate() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Create(callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        logSuccess("New ___VARIABLE_modelName___ created")
                        await self.fetchData()
                    }
                }
            }))
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
    }

    func onChangeSortType(_ sortType: ___VARIABLE_modelName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_modelName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_modelName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onTapArchive___VARIABLE_modelName___s() async {
        await state.update { $0.destination = .___VARIABLE_modelPluralVariableName___Archive }
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_modelName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    let result = await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                    switch result {
                    case .success:
                        await self.onDeleteSuccess()
                    case let .failure(error):
                        await self.onDeleteFailure(error)
                    }
                }
            }
        }
    }

    private func onDeleteSuccess() async {
        await state.update { $0.hud = .delete() }
        await fetchData()
    }

    private func onDeleteFailure(_ error: Error) async {
        await state.update { $0.alert = .error(error) }
    }

    private func onTapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        logUI("Edit action triggered for ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit(___VARIABLE_modelVariableName___, callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        logSuccess("___VARIABLE_modelName___ edit completed: \(___VARIABLE_modelVariableName___.name)")
                        await self.fetchData()
                    }
                }
            }))
        }
    }

    private func toggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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

    private func toggleArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let wasArchived = ___VARIABLE_modelVariableName___.isArchive

        let result = await ___VARIABLE_modelVariableName___StorageService.toggleArchive(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasArchived ? .unarchive() : .archive() }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func duplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await ___VARIABLE_modelVariableName___StorageService.duplicate(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }
}

public extension ___VARIABLE_modelName___ListViewModel {
    func fetchData(searchTerm: String? = nil) async {
        await fetch___VARIABLE_modelName___s(searchTerm: searchTerm)
    }
}

// MARK: - Internal helper methods

private extension ___VARIABLE_modelName___ListViewModel {
    func fetch___VARIABLE_modelName___s(searchTerm: String? = nil) async {
        if await state.___VARIABLE_modelPluralVariableName___State.isResult != true {
            await state.update { $0.___VARIABLE_modelPluralVariableName___State = .loading }
        }

        let stateSearchTerm = await state.searchTerm
        let currentSearchTerm = searchTerm ?? stateSearchTerm
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        let result: Result<[___VARIABLE_modelName___], Error>

        if currentSearchTerm.isEmpty {
            switch filterType {
            case .standard:
                result = await ___VARIABLE_modelVariableName___StorageService.fetchAllSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
            case .archived:
                result = await ___VARIABLE_modelVariableName___StorageService.fetchArchivedSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                )
            case .favorites:
                result = await ___VARIABLE_modelVariableName___StorageService.fetchFavoritesSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                )
            }
        } else {
            switch filterType {
            case .standard:
                result = await ___VARIABLE_modelVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
            case .archived:
                let searchResult = await ___VARIABLE_modelVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: true,
                )
                switch searchResult {
                case let .success(products):
                    let archivedProducts = products.filter { $0.isArchive }
                    result = .success(archivedProducts)
                case let .failure(error):
                    result = .failure(error)
                }
            case .favorites:
                let searchResult = await ___VARIABLE_modelVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
                switch searchResult {
                case let .success(products):
                    let favoriteProducts = products.filter { $0.isFavorite }
                    result = .success(favoriteProducts)
                case let .failure(error):
                    result = .failure(error)
                }
            }
        }

        switch result {
        case let .success(products):
            await state.update { $0.___VARIABLE_modelPluralVariableName___State = .result(products) }
        case let .failure(error):
            await state.update { $0.___VARIABLE_modelPluralVariableName___State = .error(error) }
        }
    }
}
