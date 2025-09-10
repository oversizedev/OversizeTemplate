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

public extension ___VARIABLE_categoryName___ListViewModel {
    enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreate___VARIABLE_categoryName___
        case onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryName___)
        case onToggleFavorite(___VARIABLE_categoryName___)
        case onToggleArchive(___VARIABLE_categoryName___)
        case onTapDisplayType(___VARIABLE_categoryName___ListDisplayType)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onChangeSortType(___VARIABLE_categoryName___SortType)
        case onChangeSortOrder(___VARIABLE_categoryName___SortOrder)
        case onChangeFilterType(___VARIABLE_categoryName___FilterType)
        case onTapArchive___VARIABLE_categoryName___s
        case onToggleCompactView
        case onChangeViewOption(___VARIABLE_categoryName___ViewOption)
    }
}

public actor ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_categoryName___ListViewState

    /// Initialization
    public init(state: ___VARIABLE_categoryName___ListViewState) {
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
        case let .onTapDelete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await delete___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onTapDuplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await duplicate___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case let .onToggleFavorite(___VARIABLE_categoryVariableName___):
            await toggleFavorite(___VARIABLE_categoryVariableName___)
        case let .onToggleArchive(___VARIABLE_categoryVariableName___):
            await toggleArchive(___VARIABLE_categoryVariableName___)
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        case .onTapCreate___VARIABLE_categoryName___:
            await onCreate()
        case let .onChangeSortType(sortType):
            await onChangeSortType(sortType)
        case let .onChangeSortOrder(sortOrder):
            await onChangeSortOrder(sortOrder)
        case let .onChangeFilterType(filterType):
            await onChangeFilterType(filterType)
        case .onTapArchive___VARIABLE_categoryName___s:
            await onTapArchive___VARIABLE_categoryName___s()
        case .onToggleCompactView:
            await onToggleCompactView()
        case let .onChangeViewOption(viewOption):
            await onChangeViewOption(viewOption)
        case let .onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___):
            await onTapEdit___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___)
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___ListViewModel {
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
            viewState.destination = .___VARIABLE_categoryVariableName___Create(callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        logSuccess("New ___VARIABLE_categoryName___ created")
                        await self.fetchData()
                    }
                }
            }))
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_categoryName___ListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetail___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.update { $0.destination = .___VARIABLE_categoryVariableName___Details___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___) }
    }

    func onChangeSortType(_ sortType: ___VARIABLE_categoryName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_categoryName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_categoryName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onTapArchive___VARIABLE_categoryName___s() async {
        await state.update { $0.destination = .___VARIABLE_categoryPluralVariableName___Archive }
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_categoryName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    private func delete___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    let result = await self.___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
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

    private func onTapEdit___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        logUI("Edit action triggered for ___VARIABLE_categoryName___: \(___VARIABLE_categoryVariableName___.name)")
        await state.update {
            $0.destination = .___VARIABLE_categoryVariableName___Edit(___VARIABLE_categoryVariableName___, callback: .init(handler: { action in
                switch action {
                case .save:
                    Task {
                        logSuccess("___VARIABLE_categoryName___ edit completed: \(___VARIABLE_categoryVariableName___.name)")
                        await self.fetchData()
                    }
                }
            }))
        }
    }

    private func toggleFavorite(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        let wasFavorite = ___VARIABLE_categoryVariableName___.isFavorite
        let result = await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func toggleArchive(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        let wasArchived = ___VARIABLE_categoryVariableName___.isArchive

        let result = await ___VARIABLE_categoryVariableName___StorageService.toggleArchive(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = wasArchived ? .unarchive() : .archive() }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }

    private func duplicate___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) async {
        let result = await ___VARIABLE_categoryVariableName___StorageService.duplicate(___VARIABLE_categoryVariableName___)
        switch result {
        case .success:
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        case let .failure(error):
            await state.update { $0.alert = .error(error) }
        }
    }
}

public extension ___VARIABLE_categoryName___ListViewModel {
    func fetchData(searchTerm: String? = nil) async {
        await fetch___VARIABLE_categoryName___s(searchTerm: searchTerm)
    }
}

// MARK: - Internal helper methods

private extension ___VARIABLE_categoryName___ListViewModel {
    func fetch___VARIABLE_categoryName___s(searchTerm: String? = nil) async {
        if await state.___VARIABLE_categoryPluralVariableName___State.isResult != true {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .loading }
        }

        let stateSearchTerm = await state.searchTerm
        let currentSearchTerm = searchTerm ?? stateSearchTerm
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        let result: Result<[___VARIABLE_categoryName___], Error>

        if currentSearchTerm.isEmpty {
            switch filterType {
            case .standard:
                result = await ___VARIABLE_categoryVariableName___StorageService.fetchAllSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
            case .archived:
                result = await ___VARIABLE_categoryVariableName___StorageService.fetchArchivedSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                )
            case .favorites:
                result = await ___VARIABLE_categoryVariableName___StorageService.fetchFavoritesSorted(
                    sortType: sortType,
                    sortOrder: sortOrder,
                )
            }
        } else {
            switch filterType {
            case .standard:
                result = await ___VARIABLE_categoryVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
            case .archived:
                let searchResult = await ___VARIABLE_categoryVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: true,
                )
                switch searchResult {
                case let .success(categories):
                    let archivedCategories = categories.filter { $0.isArchive }
                    result = .success(archivedCategories)
                case let .failure(error):
                    result = .failure(error)
                }
            case .favorites:
                let searchResult = await ___VARIABLE_categoryVariableName___StorageService.searchSorted(
                    query: currentSearchTerm,
                    sortType: sortType,
                    sortOrder: sortOrder,
                    includeArchived: false,
                )
                switch searchResult {
                case let .success(categories):
                    let favoriteCategories = categories.filter { $0.isFavorite }
                    result = .success(favoriteCategories)
                case let .failure(error):
                    result = .failure(error)
                }
            }
        }

        switch result {
        case let .success(categories):
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .result(categories) }
        case let .failure(error):
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
        }
    }
}