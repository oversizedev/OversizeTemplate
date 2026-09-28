// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Detail.self)
public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    private var saveTask: Task<Void, Never>?

    func onAppear() async {
        let hasLoadedData = await state.state.result != nil
        await fetchData(showsLoading: !hasLoadedData)
    }

    func onTapEdit___VARIABLE_modelName___() async {
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

    func onTapDelete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    Log.debug("Attempting to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
                    do {
                        try await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                        Log.info("___VARIABLE_modelName___ deleted: \(___VARIABLE_modelVariableName___.name)")
                        await self.state.update { $0.isDismissed = true }
                        self.output?.onDelete?(___VARIABLE_modelVariableName___)
                    } catch {
                        Log.error("Failed to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)", error: error)
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapToggleFavorite() async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else {
                Log.warning("Cannot toggle favorite - no ___VARIABLE_modelName___ loaded")
                return
            }

            let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite

            do {
                let updated___VARIABLE_modelName___ = try await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
                await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
                await fetchData()
                output?.onEdit?(updated___VARIABLE_modelName___)
            } catch {
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }

    func onTapSelect___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        if let saveTask {
            return await saveTask.value
        }
        let task = Task {
            defer { saveTask = nil }
            guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else {
                Log.warning("Cannot select ___VARIABLE_categoryName___ - no ___VARIABLE_modelName___ loaded")
                return
            }

            do {
                let updated___VARIABLE_modelName___ = try await ___VARIABLE_modelVariableName___StorageService.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
                await state.update { $0.hud = ___VARIABLE_categoryVariableName___ != nil ? .success("___VARIABLE_categoryName___ assigned") : .success("___VARIABLE_categoryName___ removed") }
                await fetchData()
                output?.onEdit?(updated___VARIABLE_modelName___)
            } catch {
                await state.update { $0.alert = .error(error) }
            }
        }
        saveTask = task
        await task.value
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }
}

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData(showsLoading: Bool = false) async {
        if showsLoading {
            await state.update { $0.state = .loading }
        }
        do {
            async let ___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
            async let ___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryVariableName___StorageService.fetch()
            let stateModel = try await ___VARIABLE_modelName___DetailViewState.StateModel(
                ___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___
            )
            await state.update { $0.state = .result(stateModel) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
