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
        await fetchData()
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

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                Task {
                    await self.performDelete(___VARIABLE_modelVariableName___)
                }
            }
        }
    }

    private func performDelete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let result = await storageService.delete(___VARIABLE_modelVariableName___)
        switch result {
        case .success:
            logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
            await fetchData()
        case .failure(let error):
            await state.update {
                $0.alert = .error(error)
            }
        }
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData(force _: Bool = false) async {
        await state.update {
            $0.___VARIABLE_modelPluralVariableName___State = .loading
        }

        let result = await fetch___VARIABLE_modelName___()
        switch result {
        case let .success(___VARIABLE_modelPluralVariableName___):
            let filtered___VARIABLE_modelName___ = await applyFilters(___VARIABLE_modelPluralVariableName___)
            await state.update {
                $0.___VARIABLE_modelPluralVariableName___State = .result(filtered___VARIABLE_modelName___)
            }
        case let .failure(error):
            await state.update {
                $0.___VARIABLE_modelPluralVariableName___State = .error(error)
            }
        }
    }

    private func fetch___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
        let filterType = await state.storage.filterType
        
        switch filterType {
        case .all:
            return await storageService.fetch___VARIABLE_modelName___()
        case .favorites:
            return await storageService.fetchFavorite___VARIABLE_modelName___()
        case .archived:
            return await storageService.fetchArchived___VARIABLE_modelName___()
        }
    }

    private func applyFilters(_ ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]) async -> [___VARIABLE_modelName___] {
        let searchTerm = await state.searchTerm.lowercased()
        
        guard !searchTerm.isEmpty else {
            return ___VARIABLE_modelPluralVariableName___
        }
        
        return ___VARIABLE_modelPluralVariableName___.filter { ___VARIABLE_modelVariableName___ in
            ___VARIABLE_modelVariableName___.name.lowercased().contains(searchTerm) ||
            (___VARIABLE_modelVariableName___.note?.lowercased().contains(searchTerm) ?? false)
        }
    }
}
