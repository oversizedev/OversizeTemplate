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

public extension ___VARIABLE_categoryName___EditViewModel {
    enum Action: Sendable {
        case onSave
        case onCancel
    }
}

public actor ___VARIABLE_categoryName___EditViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    /// ViewState
    public var state: ___VARIABLE_categoryName___EditViewState

    /// Initialization
    public init(state: ___VARIABLE_categoryName___EditViewState) {
        self.state = state
    }

    public func handleAction(_ action: Action) async {
        switch action {
        case .onSave:
            await onSave()
        case .onCancel:
            await onCancel()
        }
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___EditViewModel {
    func onSave() async {
        let isEdit = await state.isEdit
        let ___VARIABLE_categoryVariableName___Id = await state.___VARIABLE_categoryVariableName___Id
        let name = await state.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let description = await state.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let color = await state.color
        let isFavorite = await state.isFavorite
        let isArchive = await state.isArchive

        guard !name.isEmpty else {
            await state.update { $0.alert = .error("Name is required") }
            return
        }

        let result: Result<___VARIABLE_categoryName___, Error>

        if isEdit, let ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id {
            // Update existing category
            result = await ___VARIABLE_categoryVariableName___StorageService.update(
                id: ___VARIABLE_categoryVariableName___Id,
                name: name,
                description: description,
                color: color,
                isFavorite: isFavorite,
                isArchive: isArchive
            )
        } else {
            // Create new category
            let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryName___(
                name: name,
                description: description,
                color: color,
                isFavorite: isFavorite,
                isArchive: isArchive
            )
            result = await ___VARIABLE_categoryVariableName___StorageService.save(___VARIABLE_categoryVariableName___)
        }

        switch result {
        case .success:
            await onSaveSuccess()
        case let .failure(error):
            await onSaveFailure(error)
        }
    }

    func onCancel() async {
        await state.update { $0.isDismissed = true }
    }

    private func onSaveSuccess() async {
        await state.update { viewState in
            viewState.isDismissed = true
            viewState.callback?.handler(.save)
        }
    }

    private func onSaveFailure(_ error: Error) async {
        await state.update { $0.alert = .error(error) }
    }
}