// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___Detail.self)
public actor ___VARIABLE_categoryName___DetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_categoryVariableName___StorageService) var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService

    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onTapEdit___VARIABLE_categoryName___() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else { return }
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Edit(
                ___VARIABLE_categoryVariableName___,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onTapDelete___VARIABLE_categoryName___() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.___VARIABLE_categoryVariableName___StorageService.delete(___VARIABLE_categoryVariableName___)
                        await self.state.update { viewState in
                            viewState.hud = .delete
                            viewState.isDismissed = true
                        }
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapToggleFavorite() async {
        guard let ___VARIABLE_categoryVariableName___ = await state.state.result?.___VARIABLE_categoryVariableName___ else {
            logWarning("Cannot toggle favorite - no ___VARIABLE_categoryName___ loaded")
            return
        }
        let wasFavorite = ___VARIABLE_categoryVariableName___.isFavorite

        do {
            _ = try await ___VARIABLE_categoryVariableName___StorageService.toggleFavorite(___VARIABLE_categoryVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func on___VARIABLE_modelName___Action(_ action: ___VARIABLE_modelName___ListContentView.Action) async {
        switch action {
        case let .tapItem(___VARIABLE_modelVariableName___):
            await tapDetail___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .editProduct(___VARIABLE_modelVariableName___):
            await tapEdit___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .toggleFavorite(___VARIABLE_modelVariableName___):
            await tapToggleFavorite(___VARIABLE_modelVariableName___)
        case let .duplicateProduct(___VARIABLE_modelVariableName___):
            await tapDuplicate___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .deleteProduct(___VARIABLE_modelVariableName___):
            await tapDelete___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        case let .select___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___):
            await tapSelect___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, ___VARIABLE_categoryVariableName___)
        case let .create___VARIABLE_categoryName___For___VARIABLE_modelName___(___VARIABLE_modelVariableName___):
            await tapCreate___VARIABLE_categoryName___For___VARIABLE_modelName___(___VARIABLE_modelVariableName___)
        }
    }
}

private extension ___VARIABLE_categoryName___DetailViewModel {
    func fetchData() async {
        await state.update { $0.state = .loading }
        do {
            async let ___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___StorageService.fetch(by: state.___VARIABLE_categoryVariableName___Id)
            async let ___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelVariableName___StorageService.fetch(
                filterType: .standard,
                sortType: .date,
                sortOrder: .descending,
                ___VARIABLE_categoryVariableName___Id: state.___VARIABLE_categoryVariableName___Id
            )
            async let ___VARIABLE_categoryPluralVariableName___ = ___VARIABLE_categoryVariableName___StorageService.fetch()
            let model = try await ___VARIABLE_categoryName___DetailViewState.StateModel(
                ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryVariableName___,
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___
            )
            await state.update { $0.state = .result(model) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }

    func tapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
    }

    func tapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        logUI("Edit action triggered for ___VARIABLE_modelName___: \(___VARIABLE_modelVariableName___.name)")
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___Edit(
                ___VARIABLE_modelVariableName___,
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func tapToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func tapDuplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.duplicate(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func tapDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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

    func tapSelect___VARIABLE_categoryName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___?) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.update___VARIABLE_categoryName___(___VARIABLE_modelVariableName___, categoryId: ___VARIABLE_categoryVariableName___?.id)
            await state.update { $0.hud = ___VARIABLE_categoryVariableName___ != nil ? .success("___VARIABLE_categoryName___ assigned") : .success("___VARIABLE_categoryName___ removed") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func tapCreate___VARIABLE_categoryName___For___VARIABLE_modelName___(_: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_categoryVariableName___Create(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }
}
