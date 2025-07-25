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
    /// @Injected(\.service) var service

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
        // TODO: Implement toggle favorite logic
        logInfo("Toggle favorite for ___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
    }

    func onTapArchive(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        // TODO: Implement archive logic
        logInfo("Archive ___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
                // TODO: Implement actual deletion logic
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
        // TODO: Implement actual data fetching based on filter type and search term
        var mock___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___] = [
            .init(id: UUID(), name: "___VARIABLE_modelName___ 1", color: Color.red, date: Date()),
            .init(id: UUID(), name: "___VARIABLE_modelName___ 2", color: Color.blue, date: Date()),
            .init(id: UUID(), name: "___VARIABLE_modelName___ 3", color: Color.green, date: Date()),
        ]

        // Apply filter
        switch filterType {
        case .all:
            break // No filtering needed
        case .favorites:
            mock___VARIABLE_modelPluralVariableName___ = mock___VARIABLE_modelPluralVariableName___.filter { $0.isFavorite }
        case .archived:
            mock___VARIABLE_modelPluralVariableName___ = mock___VARIABLE_modelPluralVariableName___.filter { $0.isArchive }
        }

        // Apply search term filtering
        if let searchTerm = searchTerm, !searchTerm.isEmpty {
            mock___VARIABLE_modelPluralVariableName___ = mock___VARIABLE_modelPluralVariableName___.filter {
                $0.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }

        return .success(mock___VARIABLE_modelPluralVariableName___)
    }
}
