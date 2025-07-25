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
        case onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType)
        case onChangeSearchTerm(oldValue: String, newValue: String)
        case onTapFilterType(_ filterType: ___VARIABLE_modelName___FilterType)
        case onTapViewOption(_ viewOption: ___VARIABLE_modelName___ViewOption)
        case onTapGridSize(_ gridSize: ___VARIABLE_modelName___GridSize)
        case onTapToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
        case onTapArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    }
}

public actor ___VARIABLE_modelName___ListViewModel {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var storageService

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
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case .onTapCreate___VARIABLE_modelName___:
            await onCreate()
        case let .onTapFilterType(filterType):
            await onTapFilterType(filterType)
        case let .onTapViewOption(viewOption):
            await onTapViewOption(viewOption)
        case let .onTapGridSize(gridSize):
            await onTapGridSize(gridSize)
        case let .onTapToggleFavorite(___VARIABLE_modelVariableName___):
            await onTapToggleFavorite(___VARIABLE_modelVariableName___)
        case let .onTapArchive(___VARIABLE_modelVariableName___):
            await onTapArchive(___VARIABLE_modelVariableName___)
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

    func onChangeSearchTerm(oldValue _: String, newValue _: String) async {
        // Implement search filtering logic
        await fetchData(searchTerm: newValue)
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

    func onTapFilterType(_ filterType: ___VARIABLE_modelName___FilterType) async {
        await state.update {
            $0.storage.filterType = filterType
        }
        await fetchData()
    }

    func onTapViewOption(_ viewOption: ___VARIABLE_modelName___ViewOption) async {
        await state.update {
            $0.storage.viewOption = viewOption
        }
    }

    func onTapGridSize(_ gridSize: ___VARIABLE_modelName___GridSize) async {
        await state.update {
            $0.storage.gridSize = gridSize
        }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    func onTapToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await storageService.update___VARIABLE_modelName___(
            ___VARIABLE_modelName___: ___VARIABLE_modelVariableName___,
            isFavorite: !___VARIABLE_modelVariableName___.isFavorite
        )
        await fetchData() // Refresh the list
        logInfo("Toggle favorite for ___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
    }

    func onTapArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await storageService.update___VARIABLE_modelName___(
            ___VARIABLE_modelName___: ___VARIABLE_modelVariableName___,
            isArchive: !___VARIABLE_modelVariableName___.isArchive
        )
        await fetchData() // Refresh the list
        logInfo("Archive ___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                Task {
                    await self.storageService.delete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
                    await self.fetchData() // Refresh the list
                }
                logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
            }
        }
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData(force _: Bool = false, searchTerm: String? = nil) async {
        await state.update {
            $0.___VARIABLE_modelPluralVariableName___State = .loading
        }

        let filterType = await state.storage.filterType
        let result = await fetch___VARIABLE_modelName___(filterType: filterType, searchTerm: searchTerm)
        
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

    private func fetch___VARIABLE_modelName___(filterType: ___VARIABLE_modelName___FilterType = .all, searchTerm: String? = nil) async -> Result<[___VARIABLE_modelName___], AppError> {
        let result: Result<[___VARIABLE_modelName___], AppError>
        
        switch filterType {
        case .all:
            result = await storageService.fetch___VARIABLE_modelName___()
        case .favorites:
            result = await storageService.fetchFavorite___VARIABLE_modelName___()
        case .archived:
            result = await storageService.fetchArchived___VARIABLE_modelName___()
        }

        // Apply search term filtering to the results
        switch result {
        case let .success(___VARIABLE_modelPluralVariableName___):
            var filtered___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___
            if let searchTerm = searchTerm, !searchTerm.isEmpty {
                filtered___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelPluralVariableName___.filter {
                    $0.name.localizedCaseInsensitiveContains(searchTerm) ||
                    ($0.note?.localizedCaseInsensitiveContains(searchTerm) ?? false)
                }
            }
            return .success(filtered___VARIABLE_modelPluralVariableName___)
        case .failure:
            return result
        }
    }
}
