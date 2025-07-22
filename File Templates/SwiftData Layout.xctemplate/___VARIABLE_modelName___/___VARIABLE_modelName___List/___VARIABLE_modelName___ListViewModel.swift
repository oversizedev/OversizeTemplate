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

extension ___VARIABLE_modelName___ListViewModel {
    enum InputEvent {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreate___VARIABLE_modelName___
        case onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapDuplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapToggleFavorite___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapToggleArchive___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType)
        case onTapFilterType(_ filterType: ___VARIABLE_modelName___ListFilterType)
        case onTapSortType(_ sortType: ___VARIABLE_modelName___ListSortType)
        case onTapSortOrder(_ sortOrder: ___VARIABLE_modelName___ListSortOrder)
        case onTapGridSize(_ gridSize: ___VARIABLE_modelName___ListGridSize)
        case onToggleViewOption(_ option: ___VARIABLE_modelName___ListViewOption)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onTapSelectItem(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapSelectAll
        case onTapDeselectAll
        case onTapBatchDelete
        case onTapBatchFavorite(_ isFavorite: Bool)
        case onTapBatchArchive(_ isArchive: Bool)
        case onTapExitSelectionMode
        case onTapToggleFilters
        case onTapToggleSortOptions
        case onTapToggleViewOptions
    }
}

public actor ___VARIABLE_modelName___ListViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) private var storageService: ___VARIABLE_modelName___StorageService

    /// ViewState
    public var state: ___VARIABLE_modelName___ListViewState

    /// Initialization
    public init(state: ___VARIABLE_modelName___ListViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
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
        case let .onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onTapToggleFavorite___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapToggleFavorite___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onTapToggleArchive___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapToggleArchive___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapFilterType(filterType):
            await onTapFilterType(filterType)
        case let .onTapSortType(sortType):
            await onTapSortType(sortType)
        case let .onTapSortOrder(sortOrder):
            await onTapSortOrder(sortOrder)
        case let .onTapGridSize(gridSize):
            await onTapGridSize(gridSize)
        case let .onToggleViewOption(option):
            await onToggleViewOption(option)
        case let .onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case .onTapCreate___VARIABLE_modelName___:
            await onCreate()
        case let .onTapSelectItem(___VARIABLE_modelVariableName___):
            await onTapSelectItem(___VARIABLE_modelVariableName___)
        case .onTapSelectAll:
            await onTapSelectAll()
        case .onTapDeselectAll:
            await onTapDeselectAll()
        case .onTapBatchDelete:
            await onTapBatchDelete()
        case let .onTapBatchFavorite(isFavorite):
            await onTapBatchFavorite(isFavorite)
        case let .onTapBatchArchive(isArchive):
            await onTapBatchArchive(isArchive)
        case .onTapExitSelectionMode:
            await onTapExitSelectionMode()
        case .onTapToggleFilters:
            await onTapToggleFilters()
        case .onTapToggleSortOptions:
            await onTapToggleSortOptions()
        case .onTapToggleViewOptions:
            await onTapToggleViewOptions()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___ListViewModel {
    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onChangeSearchTerm(oldValue: String, newValue: String) async {
        await state.update {
            $0.storage.lastSearchTerm = newValue
        }
        
        // Debounce search
        try? await Task.sleep(nanoseconds: 300_000_000) // 300ms
        
        // Check if search term hasn't changed during debounce
        let currentSearchTerm = await state.searchTerm
        guard currentSearchTerm == newValue else { return }
        
        await fetchData()
    }

    func onTapSearch() async {
        await state.update {
            $0.isSearch.toggle()
            if !$0.isSearch {
                $0.searchTerm = ""
            }
        }
        
        let isSearch = await state.isSearch
        if !isSearch {
            await fetchData()
        }
    }

    func onCreate() async {
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___create { [weak self] ___VARIABLE_modelVariableName___ in
                Task { await self?.fetchData(force: true) }
            }
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType) async {
        await state.update {
            $0.storage.displayType = displayType
        }
    }

    func onTapFilterType(_ filterType: ___VARIABLE_modelName___ListFilterType) async {
        await state.update {
            $0.storage.filterType = filterType
            $0.isShowingFilters = false
        }
        await fetchData()
    }

    func onTapSortType(_ sortType: ___VARIABLE_modelName___ListSortType) async {
        await state.update {
            $0.storage.sortType = sortType
            $0.isShowingSortOptions = false
        }
        await fetchData()
    }

    func onTapSortOrder(_ sortOrder: ___VARIABLE_modelName___ListSortOrder) async {
        await state.update {
            $0.storage.sortOrder = sortOrder
            $0.isShowingSortOptions = false
        }
        await fetchData()
    }

    func onTapGridSize(_ gridSize: ___VARIABLE_modelName___ListGridSize) async {
        await state.update {
            $0.storage.gridSize = gridSize
        }
    }

    func onToggleViewOption(_ option: ___VARIABLE_modelName___ListViewOption) async {
        await state.update {
            $0.storage.toggleViewOption(option)
        }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let isSelectionMode = await state.isSelectionMode
        if isSelectionMode {
            await onTapSelectItem(___VARIABLE_modelVariableName___)
        } else {
            await state.update {
                $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
            }
        }
    }

    func onTapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) { [weak self] updatedItem in
                Task { await self?.fetchData(force: true) }
            }
        }
    }

    func onTapDuplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await storageService.duplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case .success:
            await fetchData(force: true)
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    func onTapToggleFavorite___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await storageService.toggleFavorite___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case .success:
            await fetchData(force: true)
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    func onTapToggleArchive___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await storageService.toggleArchive___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        
        switch result {
        case .success:
            await fetchData(force: true)
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                Task {
                    let result = await self.storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
                    switch result {
                    case .success:
                        await self.fetchData(force: true)
                        logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
                    case let .failure(error):
                        await self.state.update {
                            $0.alert = .error(error)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Selection Actions

    func onTapSelectItem(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.toggleSelection(for: ___VARIABLE_modelVariableName___)
        }
    }

    func onTapSelectAll() async {
        await state.update {
            $0.toggleSelectAll()
        }
    }

    func onTapDeselectAll() async {
        await state.update {
            $0.deselectAll()
        }
    }

    func onTapExitSelectionMode() async {
        await state.update {
            $0.exitSelectionMode()
        }
    }

    func onTapBatchDelete() async {
        let selectedIds = await state.selectedItems
        let allItemsState = await state.___VARIABLE_modelPluralVariableName___State
        guard let allItems = allItemsState.result else { return }
        let selectedItems = allItems.filter { selectedIds.contains($0.id) }
        
        await state.update {
            $0.alert = .delete {
                Task {
                    let result = await self.storageService.batchDelete___VARIABLE_modelName___(selectedItems)
                    switch result {
                    case .success:
                        await self.state.update {
                            $0.exitSelectionMode()
                        }
                        await self.fetchData(force: true)
                        logDeleted("\(selectedItems.count) ___VARIABLE_modelName___(s)")
                    case let .failure(error):
                        await self.state.update {
                            $0.alert = .error(error)
                        }
                    }
                }
            }
        }
    }

    func onTapBatchFavorite(_ isFavorite: Bool) async {
        let selectedIds = await state.selectedItems
        let allItemsState = await state.___VARIABLE_modelPluralVariableName___State
        guard let allItems = allItemsState.result else { return }
        let selectedItems = allItems.filter { selectedIds.contains($0.id) }
        
        let result = await storageService.batchToggleFavorite___VARIABLE_modelName___(selectedItems, isFavorite: isFavorite)
        
        switch result {
        case .success:
            await state.update {
                $0.exitSelectionMode()
            }
            await fetchData(force: true)
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    func onTapBatchArchive(_ isArchive: Bool) async {
        let selectedIds = await state.selectedItems
        let allItemsState = await state.___VARIABLE_modelPluralVariableName___State
        guard let allItems = allItemsState.result else { return }
        let selectedItems = allItems.filter { selectedIds.contains($0.id) }
        
        let result = await storageService.batchToggleArchive___VARIABLE_modelName___(selectedItems, isArchive: isArchive)
        
        switch result {
        case .success:
            await state.update {
                $0.exitSelectionMode()
            }
            await fetchData(force: true)
        case let .failure(error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }

    // MARK: - UI Actions

    func onTapToggleFilters() async {
        await state.update {
            $0.isShowingFilters.toggle()
            if $0.isShowingFilters {
                $0.isShowingSortOptions = false
                $0.isShowingViewOptions = false
            }
        }
    }

    func onTapToggleSortOptions() async {
        await state.update {
            $0.isShowingSortOptions.toggle()
            if $0.isShowingSortOptions {
                $0.isShowingFilters = false
                $0.isShowingViewOptions = false
            }
        }
    }

    func onTapToggleViewOptions() async {
        await state.update {
            $0.isShowingViewOptions.toggle()
            if $0.isShowingViewOptions {
                $0.isShowingFilters = false
                $0.isShowingSortOptions = false
            }
        }
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData(force: Bool = false) async {
        // Set loading state if forced or if currently idle
        let itemsStateIsIdle = await state.___VARIABLE_modelPluralVariableName___State.isIdle
        if force || itemsStateIsIdle {
            await state.update {
                $0.___VARIABLE_modelPluralVariableName___State = .loading
            }
        }
        
        let filterType = await state.storage.filterType
        let searchTerm = await state.searchTerm
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        
        let result = await storageService.fetch___VARIABLE_modelName___(
            filterType: filterType,
            searchTerm: searchTerm,
            sortType: sortType,
            sortOrder: sortOrder
        )
        
        switch result {
        case let .success(___VARIABLE_modelPluralVariableName___):
            await state.update {
                $0.___VARIABLE_modelPluralVariableName___State = .result(___VARIABLE_modelPluralVariableName___)
            }
        case let .failure(error):
            await state.update {
                $0.___VARIABLE_modelPluralVariableName___State = .error(error)
            }
        }
    }
}
