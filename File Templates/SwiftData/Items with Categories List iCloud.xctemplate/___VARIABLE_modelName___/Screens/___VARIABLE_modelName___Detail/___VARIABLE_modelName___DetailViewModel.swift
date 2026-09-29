// ___FILEHEADER___

import Env
import Services
import FactoryKit
import Models
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Detail.self)
public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {
    @Injected(\.___VARIABLE_modelVariableName___Service) private var ___VARIABLE_modelVariableName___Service: ___VARIABLE_modelName___Service
    @Injected(\.___VARIABLE_categoryVariableName___Service) private var ___VARIABLE_categoryVariableName___Service: ___VARIABLE_categoryName___Service

    private var saveTask: Task<Void, Never>?

    // MARK: - User Actions

    func onAppear() async {
        let hasLoadedData = await state.state.result != nil
        await fetchData(showsLoading: !hasLoadedData)
    }

    func onTapEdit() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: Callback { updated___VARIABLE_modelName___ in
                    Task {
                        await self.fetchData()
                        self.output?.onEdit?(updated___VARIABLE_modelName___)
                    }
                }
            )
        }
    }

    func onTapDelete() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task { await self.delete(___VARIABLE_modelVariableName___) }
            }
        }
    }

    func onTapToggleFavorite() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await performWrite {
            let updated___VARIABLE_modelName___ = try await self.___VARIABLE_modelVariableName___Service.toggleFavorite(___VARIABLE_modelVariableName___)
            await self.state.update { $0.hud = updated___VARIABLE_modelName___.isFavorite ? .favorite : .unfavorite }
            await self.fetchData()
            self.output?.onEdit?(updated___VARIABLE_modelName___)
        }
    }

    func onTapSelectCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        await assignCategory(___VARIABLE_categoryVariableName___, showsHUD: true)
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { ___VARIABLE_categoryVariableName___ in
                    Task { await self.assignCategory(___VARIABLE_categoryVariableName___, showsHUD: false) }
                }
            )
        }
    }
}

// MARK: - Write Operations

private extension ___VARIABLE_modelName___DetailViewModel {
    func assignCategory(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?, showsHUD: Bool) async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await performWrite {
            let updated___VARIABLE_modelName___ = try await self.___VARIABLE_modelVariableName___Service.update___VARIABLE_categoryName___(
                ___VARIABLE_modelVariableName___,
                categoryId: ___VARIABLE_categoryVariableName___?.id
            )
            if showsHUD {
                await self.state.update { $0.hud = ___VARIABLE_categoryVariableName___ == nil ? .success("Category removed") : .success("Category assigned") }
            }
            await self.fetchData()
            self.output?.onEdit?(updated___VARIABLE_modelName___)
        }
    }

    func delete(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await performWrite {
            try await self.___VARIABLE_modelVariableName___Service.delete(___VARIABLE_modelVariableName___)
            await self.state.update { $0.isDismissed = true }
            self.output?.onDelete?(___VARIABLE_modelVariableName___)
        }
    }

    func performWrite(_ operation: @Sendable @escaping () async throws -> Void) async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            do {
                try await operation()
            } catch {
                Log.error("___VARIABLE_modelName___ write failed:", error: error)
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }
}

// MARK: - Data Fetching

private extension ___VARIABLE_modelName___DetailViewModel {
    func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }
        do {
            async let ___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___Service.fetch(by: state.___VARIABLE_modelVariableName___Id)
            async let ___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryVariableName___Service.fetch()
            let model = try await ___VARIABLE_modelName___DetailViewState.StateModel(
                ___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___
            )
            await state.update { $0.state = .result(model) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
