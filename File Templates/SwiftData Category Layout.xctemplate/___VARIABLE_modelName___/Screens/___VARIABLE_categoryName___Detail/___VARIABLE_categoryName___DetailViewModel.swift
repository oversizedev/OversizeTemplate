// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Detail.self)
public actor ___VARIABLE_categoryName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___CategoryStorageService) var ___VARIABLE_modelVariableName___CategoryStorageService: ___VARIABLE_categoryName___StorageService
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService

    func onAppear() async {
        if await state.___VARIABLE_categoryVariableName___State.successResult == nil {
            await fetchData()
        } else {
            await fetch___VARIABLE_categoryPluralVariableName___()
            await incrementViewCount()
            await fetch___VARIABLE_modelName___s()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onTapEdit___VARIABLE_categoryName___() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___CategoryEdit(
                ___VARIABLE_categoryVariableName___,
                onSave: { _ in
                    Task {
                        logSuccess("___VARIABLE_categoryName___ edit completed")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDelete___VARIABLE_categoryName___() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    logData("Attempting to delete ___VARIABLE_categoryName___: \(___VARIABLE_categoryVariableName___.name)")
                    do {
                        try await self.___VARIABLE_modelVariableName___CategoryStorageService.delete(___VARIABLE_categoryVariableName___)
                        logDeleted("___VARIABLE_categoryName___")
                        await self.onDeleteSuccess()
                    } catch {
                        logError("Failed to delete ___VARIABLE_categoryName___: \(___VARIABLE_categoryVariableName___.name)", error: error)
                        await self.onDeleteFailure(error)
                    }
                }
            }
        }
    }

    func onDeleteSuccess() async {
        await state.update { viewState in
            viewState.hud = .delete
            viewState.isDismissed = true
        }
    }

    func onDeleteFailure(_ error: Error) async {
        await state.update { $0.alert = .error(error) }
    }

    func onTapToggleFavorite() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else {
            logWarning("Cannot toggle favorite - no ___VARIABLE_categoryName___ loaded")
            return
        }
        let wasFavorite = ___VARIABLE_categoryVariableName___.isFavorite

        do {
            _ = try await ___VARIABLE_modelVariableName___CategoryStorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func on___VARIABLE_modelName___Action(_ action: ___VARIABLE_modelName___ListContentView.Action) async {
        switch action {
        case let .tapItem(___VARIABLE_modelVariableName___):
            await onTapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .editProduct(___VARIABLE_modelVariableName___):
            await onTapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .toggleFavorite(___VARIABLE_modelVariableName___):
            await onTapToggleFavorite(___VARIABLE_modelVariableName___)
        case let .duplicateProduct(___VARIABLE_modelVariableName___):
            await onTapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .deleteProduct(___VARIABLE_modelVariableName___):
            await onTapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .selectCategory(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___):
            await onTapSelect___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___)
        case let .createCategoryForProduct(___VARIABLE_modelVariableName___):
            await onTapCreate___VARIABLE_categoryName___For___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        }
    }
}

private extension ___VARIABLE_categoryName___DetailViewModel {
    func fetchData() async {
        await fetch___VARIABLE_categoryName___()
        await fetch___VARIABLE_modelName___s()
        await fetch___VARIABLE_categoryPluralVariableName___()
    }

    func fetch___VARIABLE_categoryName___() async {
        do {
            let ___VARIABLE_categoryVariableName___ = try await ___VARIABLE_modelVariableName___CategoryStorageService.fetch(by: state.___VARIABLE_categoryVariableName___Id)
            await state.update { $0.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___) }
        } catch {
            await state.update { $0.___VARIABLE_categoryVariableName___State = .error(error) }
        }
    }

    func fetch___VARIABLE_modelName___s() async {
        await state.update { $0.___VARIABLE_modelPluralVariableName___State = .loading }
        do {
            let ___VARIABLE_modelPluralVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(
                filterType: .standard,
                sortType: .date,
                sortOrder: .descending,
                categoryId: state.___VARIABLE_categoryVariableName___Id
            )
            if ___VARIABLE_modelPluralVariableName___.isEmpty {
                await state.update { $0.___VARIABLE_modelPluralVariableName___State = .empty }
            } else {
                await state.update { $0.___VARIABLE_modelPluralVariableName___State = .result(___VARIABLE_modelPluralVariableName___) }
            }
        } catch {
            await state.update { $0.___VARIABLE_modelPluralVariableName___State = .error(error) }
        }
    }

    func fetch___VARIABLE_categoryPluralVariableName___() async {
        do {
            let ___VARIABLE_categoryPluralVariableName___ = try await ___VARIABLE_modelVariableName___CategoryStorageService.fetch()
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .result(___VARIABLE_categoryPluralVariableName___) }
        } catch {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
        }
    }

    func incrementViewCount() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.___VARIABLE_categoryVariableName___State.successResult else { return }
        do {
            _ = try await ___VARIABLE_modelVariableName___CategoryStorageService.incrementViewCount(___VARIABLE_categoryVariableName___)
        } catch {
            logError("Failed to increment view count for ___VARIABLE_categoryName___", error: error)
        }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
    }

    func onTapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        logUI("Edit action triggered for ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: { _ in
                    Task {
                        logSuccess("___VARIABLE_modelName___ edit completed: \(___VARIABLE_modelVariableName___.name)")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapDuplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.duplicate(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        logDeleted("___VARIABLE_modelName___")
                        try await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetchData()
                    } catch {
                        logError("Failed to delete ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)", error: error)
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapSelect___VARIABLE_categoryName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.updateCategory(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
            await state.update { $0.hud = ___VARIABLE_categoryVariableName___ != nil ? .success("___VARIABLE_categoryName___ assigned") : .success("___VARIABLE_categoryName___ removed") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapCreate___VARIABLE_categoryName___For___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___CategoryCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New ___VARIABLE_categoryName___ created, refreshing data")
                        await self.fetchData()
                    }
                }
            )
        }
    }
}