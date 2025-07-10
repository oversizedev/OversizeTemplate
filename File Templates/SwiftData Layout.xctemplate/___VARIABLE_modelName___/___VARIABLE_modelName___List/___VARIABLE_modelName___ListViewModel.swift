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

    func onChangeSearchTerm(oldValue _: String, newValue _: String) async {}

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

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Details(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    private func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.alert = .delete {
                logDeleted("___VARIABLE_modelName___ \(___VARIABLE_modelVariableName___.name)")
            }
        }
    }
}

// MARK: - Data Fetching

extension ___VARIABLE_modelName___ListViewModel {
    private func fetchData(force _: Bool = false) async {
        let result = await fetch___VARIABLE_modelName___()
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

    private func fetch___VARIABLE_modelName___() async -> Result<[___VARIABLE_modelName___], AppError> {
        .success([
            .init(id: UUID(), name: "___VARIABLE_modelName___ 1"),
        ])
    }
}
