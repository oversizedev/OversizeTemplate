// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Detail.self)
public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetchData()
    }

    func onTapEdit___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onTapDelete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    logData("Attempting to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
                    do {
                        try await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                        logDeleted("___VARIABLE_modelName___")
                        await self.state.update { viewState in
                            viewState.hud = .delete
                            viewState.isDismissed = true
                        }
                    } catch {
                        logError("Failed to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)", error: error)
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapToggleFavorite() async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else {
            logWarning("Cannot toggle favorite - no ___VARIABLE_modelName___ loaded")
            return
        }
        let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite

        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapSelect___VARIABLE_categoryName___(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        guard let ___VARIABLE_modelVariableName___ = await state.state.result?.___VARIABLE_modelVariableName___ else {
            logWarning("Cannot select ___VARIABLE_categoryName___ - no ___VARIABLE_modelName___ loaded")
            return
        }

        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
            await state.update { $0.hud = ___VARIABLE_categoryVariableName___ != nil ? .success("___VARIABLE_categoryName___ assigned") : .success("___VARIABLE_categoryName___ removed") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
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
    private func fetchData() async {
        await state.update { $0.state = .loading }
        do {
            let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_categoryVariableName___StorageService.fetch()
            await state.update { $0.state = .result(.init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___, ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___)) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
