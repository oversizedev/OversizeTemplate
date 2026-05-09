// ___FILEHEADER___

import Database
import FactoryKit
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeUI
import SwiftData
import SwiftUI

@ViewModel(module: ___VARIABLE_modelName___List.self)
public actor ___VARIABLE_modelName___ListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.___VARIABLE_modelVariableName___StorageService) var ___VARIABLE_modelVariableName___StorageService: ___VARIABLE_modelName___StorageService
    @Injected(\.___VARIABLE_modelVariableName___CategoryStorageService) var ___VARIABLE_modelVariableName___CategoryStorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_ searchTerm: String) async {
        if searchTerm.isEmpty {
            await fetch___VARIABLE_modelName___s()
        } else {
            await fetchSearched___VARIABLE_modelName___s(searchTerm: searchTerm)
        }
    }

    func onTapSearch() async {
        await state.update { $0.isSearch.toggle() }
    }

    func onTapCreate___VARIABLE_modelName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___Create(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_modelName___ListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetail___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { $0.destination = .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___) }
    }

    func onChangeSortType(_ sortType: ___VARIABLE_modelName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetch___VARIABLE_modelName___s()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_modelName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetch___VARIABLE_modelName___s()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_modelName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetch___VARIABLE_modelName___s()
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_modelName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    private func onTapDelete___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.___VARIABLE_modelVariableName___StorageService.delete(___VARIABLE_modelVariableName___)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetch___VARIABLE_modelName___s()
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    private func onTapEdit___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
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

    private func onTapToggleFavorite(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        let wasFavorite = ___VARIABLE_modelVariableName___.isFavorite
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.toggleFavorite(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetch___VARIABLE_modelName___s()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapDuplicate___VARIABLE_modelName___(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.duplicate(___VARIABLE_modelVariableName___)
            await state.update { $0.hud = .success("Duplicated") }
            await fetch___VARIABLE_modelName___s()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapSelectCategory(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___, _ category: ___VARIABLE_categoryName___?) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___StorageService.updateCategory(___VARIABLE_modelVariableName___, categoryId: category?.id)
            await state.update { $0.hud = category != nil ? .success("Category assigned") : .success("Category removed") }
            await fetch___VARIABLE_modelName___s()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapCreateCategoryForProduct(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___CategoryCreate(
                onSave: Callback { _ in
                    Task { await self.fetchData() }
                }
            )
        }
    }

    func onProductAction(_ action: ___VARIABLE_modelName___ListContentView.Action) async {
        switch action {
        case let .tapItem(product):
            await onTapDetail___VARIABLE_modelName___(product)
        case let .editProduct(product):
            await onTapEdit___VARIABLE_modelName___(product)
        case let .toggleFavorite(product):
            await onTapToggleFavorite(product)
        case let .duplicateProduct(product):
            await onTapDuplicate___VARIABLE_modelName___(product)
        case let .deleteProduct(product):
            await onTapDelete___VARIABLE_modelName___(product)
        case let .selectCategory(product, category):
            await onTapSelectCategory(product, category)
        case let .createCategoryForProduct(product):
            await onTapCreateCategoryForProduct(product)
        }
    }
}

public extension ___VARIABLE_modelName___ListViewModel {
    func fetchData() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            async let ___VARIABLE_modelPluralVariableName___ = ___VARIABLE_modelVariableName___StorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder,
                ___VARIABLE_categoryVariableName___Id: input?.categoryId
            )
            async let categories = ___VARIABLE_modelVariableName___CategoryStorageService.fetch()
            let model = try await ___VARIABLE_modelName___ListViewState.StateModel(
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                categories: categories
            )
            await state.update { $0.state = .result(model) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }

    func fetchSearched___VARIABLE_modelName___s(searchTerm: String) async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType
        let existingCategories = await state.state.result?.categories ?? []

        do {
            let ___VARIABLE_modelPluralVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.search(
                query: searchTerm,
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            let model = ___VARIABLE_modelName___ListViewState.StateModel(
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                categories: existingCategories
            )
            await state.update { $0.state = .result(model) }

        } catch {
            await state.update { $0.state = .error(error) }
        }
    }

    func fetch___VARIABLE_modelName___s() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType
        let existingCategories = await state.state.result?.categories ?? []

        do {
            let ___VARIABLE_modelPluralVariableName___ = try await ___VARIABLE_modelVariableName___StorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder,
                ___VARIABLE_categoryVariableName___Id: input?.categoryId
            )

            let model = ___VARIABLE_modelName___ListViewState.StateModel(
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                categories: existingCategories
            )
            await state.update { $0.state = .result(model) }
        } catch {
            await state.update { $0.state = .error(error) }
        }
    }
}
