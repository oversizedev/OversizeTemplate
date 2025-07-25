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
    public enum Action: Sendable {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreate___VARIABLE_modelName___
        case onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType)
        case onTapSortType(_ sortType: ___VARIABLE_modelName___SortType)
        case onTapFilterType(_ filterType: ___VARIABLE_modelName___FilterType)
        case onToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onToggleArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onBatchDelete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___])
        case onBatchArchive(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___])
    }
}

public actor ___VARIABLE_modelName___ListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var storageService

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
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapSortType(sortType):
            await onTapSortType(sortType)
        case let .onTapFilterType(filterType):
            await onTapFilterType(filterType)
        case let .onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case .onTapCreate___VARIABLE_modelName___:
            await onCreate()
        case let .onToggleFavorite(___VARIABLE_modelVariableName___):
            await onToggleFavorite(___VARIABLE_modelVariableName___)
        case let .onToggleArchive(___VARIABLE_modelVariableName___):
            await onToggleArchive(___VARIABLE_modelVariableName___)
        case let .onBatchDelete(___VARIABLE_modelPluralVariableName___):
            await onBatchDelete(___VARIABLE_modelPluralVariableName___)
        case let .onBatchArchive(___VARIABLE_modelPluralVariableName___):
            await onBatchArchive(___VARIABLE_modelPluralVariableName___)
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

    func onChangeSearchTerm(oldValue _: String, newValue: String) async {
        await performSearch(term: newValue)
    }

    func onTapSearch() async {
        await state.update {
            $0.isSearch.toggle()
        }
    }

    func onCreate() async {
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___create
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType) async {
        await state.update {
            $0.storage.displayType = displayType
        }
    }
    
    func onTapSortType(_ sortType: ___VARIABLE_modelName___SortType) async {
        await state.update {
            $0.storage.sortType = sortType
            $0.sortType = sortType
        }
        await fetchData(force: true)
    }
    
    func onTapFilterType(_ filterType: ___VARIABLE_modelName___FilterType) async {
        await state.update {
            $0.storage.filterType = filterType
            $0.filterType = filterType
        }
        await fetchData(force: true)
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        // Increment view count
        await incrementViewCount(for: ___VARIABLE_modelVariableName___)
        
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }
    
    func onToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await updateFavoriteStatus(___VARIABLE_modelVariableName___, isFavorite: !___VARIABLE_modelVariableName___.isFavorite)
    }
    
    func onToggleArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await updateArchiveStatus(___VARIABLE_modelVariableName___, isArchive: !___VARIABLE_modelVariableName___.isArchive)
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                Task {
                    await self.performDelete(___VARIABLE_modelVariableName___)
                }
            }
        }
    }
    
    func onBatchDelete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async {
        await state.update {
            $0.alert = .delete {
                Task {
                    await self.performBatchDelete(___VARIABLE_modelPluralVariableName___)
                }
            }
        }
    }
    
    func onBatchArchive(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async {
        await performBatchArchive(___VARIABLE_modelPluralVariableName___)
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData(force: Bool = false) async {
        await state.update { $0.___VARIABLE_modelPluralVariableName___State = .loading }
        
        let result = await fetch___VARIABLE_modelName___(
            sortType: await state.sortType,
            sortOrder: await state.sortOrder,
            filterType: await state.filterType,
            searchTerm: await state.searchTerm
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

    private func fetch___VARIABLE_modelName___(
        sortType: ___VARIABLE_modelName___SortType,
        sortOrder: SortOrder,
        filterType: ___VARIABLE_modelName___FilterType,
        searchTerm: String
    ) async -> Result<[___VARIABLE_modelName___], AppError> {
        do {
            let result = await storageService.fetch___VARIABLE_modelName___(
                sortType: sortType,
                sortOrder: sortOrder,
                filterType: filterType,
                searchTerm: searchTerm.isEmpty ? nil : searchTerm
            )
            return result
        } catch {
            return .failure(AppError.coreData(type: .fetchItems))
        }
    }
    
    private func performSearch(term: String) async {
        await fetchData(force: true)
    }
    
    private func incrementViewCount(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await storageService.incrementViewCount(___VARIABLE_modelVariableName___)
    }
    
    private func updateFavoriteStatus(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, isFavorite: Bool) async {
        await storageService.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___, isFavorite: isFavorite)
        await fetchData(force: true)
    }
    
    private func updateArchiveStatus(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, isArchive: Bool) async {
        await storageService.update___VARIABLE_modelName___(___VARIABLE_modelVariableName___, isArchive: isArchive)
        await fetchData(force: true)
    }
    
    private func performDelete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        await fetchData(force: true)
    }
    
    private func performBatchDelete(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async {
        await storageService.batchDelete___VARIABLE_modelName___(___VARIABLE_modelPluralVariableName___)
        await fetchData(force: true)
    }
    
    private func performBatchArchive(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async {
        await storageService.batchArchive___VARIABLE_modelName___(___VARIABLE_modelPluralVariableName___)
        await fetchData(force: true)
    }
}
