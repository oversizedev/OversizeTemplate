// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___Detail.self)
public actor ___VARIABLE_modelName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_modelVariableName___CategoryStorageService) var ___VARIABLE_modelVariableName___CategoryStorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        if await state.___VARIABLE_modelVariableName___State.successResult == nil {
            await fetchData()
        } else {
            await incrementViewCount()
            await fetchCategories()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onTapEdit___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: { _ in
                    Task {
                        logSuccess("___VARIABLE_modelName___ edit completed")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDelete___VARIABLE_modelName___() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
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
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
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

    func incrementViewCount() async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else { return }
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.incrementViewCount(___VARIABLE_modelVariableName___)
        } catch {
            logError("Silently failed to increment view count for ___VARIABLE_modelName___", error: error)
        }
    }

    func onTapSelectCategory(_ category: ___VARIABLE_categoryName___?) async {
        guard let ___VARIABLE_modelVariableName___ = await state.___VARIABLE_modelVariableName___State.successResult else {
            logWarning("Cannot select category - no ___VARIABLE_modelName___ loaded")
            return
        }

        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.updateCategory(___VARIABLE_modelVariableName___, categoryId: category?.id)
            await state.update { $0.hud = category != nil ? .success("Category assigned") : .success("Category removed") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___CategoryCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New Category created")
                        await self.fetchData()
                    }
                }
            )
        }
    }
}

public extension ___VARIABLE_modelName___DetailViewModel {
    private func fetchData() async {
        await fetch___VARIABLE_modelName___()
        await fetchCategories()
    }

    func fetch___VARIABLE_modelName___() async {
        do {
            let ___VARIABLE_modelVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(by: state.___VARIABLE_modelVariableName___Id)
            await state.update { $0.___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___) }
        } catch {
            await state.update { $0.___VARIABLE_modelVariableName___State = .error(error) }
        }
    }

    func fetchCategories() async {
        do {
            let categories = try await ___VARIABLE_modelVariableName___CategoryStorageService.fetch()
            await state.update { $0.categoriesState = .result(categories) }
        } catch {
            await state.update { $0.categoriesState = .error(error) }
        }
    }
}