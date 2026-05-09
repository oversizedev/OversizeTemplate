// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___List.self)
public actor ___VARIABLE_modelName___ListViewModel: ViewModelProtocol {
    /// Services
    /// @Injected(\.service) var service
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
            $0.destination = .create
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType) async {
        await state.update {
            $0.storage.displayType = displayType
        }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update {
            $0.destination = .details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    func delete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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
