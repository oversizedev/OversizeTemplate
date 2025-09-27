// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import FactoryKit
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

@ViewModel(module: ___VARIABLE_categoryName___List.self)
public actor ___VARIABLE_categoryName___ListViewModel: ViewModelProtocol {
    // MARK: - Services

    @Injected(\.___VARIABLE_modelVariableName___CategoryStorageService) var ___VARIABLE_modelVariableName___CategoryStorageService: ___VARIABLE_categoryName___StorageService

    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_ searchTerm: String) async {
        if searchTerm.isEmpty {
            await fetchData()
        } else {
            await fetchSearchedCategories(searchTerm: searchTerm)
        }
    }

    func onTapSearch() async {
        await state.update { $0.isSearch.toggle() }
    }

    func onTapCreate___VARIABLE_categoryName___() async {
        await state.update { viewState in
            viewState.destination = .___VARIABLE_modelVariableName___CategoryCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New ___VARIABLE_categoryName___ created")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDisplayType(_ displayType: ___VARIABLE_categoryName___ListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetail___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update { $0.destination = .___VARIABLE_modelVariableName___CategoryDetails___VARIABLE_categoryName___(___VARIABLE_modelVariableName___Category: category) }
    }

    func onChangeSortType(_ sortType: ___VARIABLE_categoryName___SortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: ___VARIABLE_categoryName___SortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeFilterType(_ filterType: ___VARIABLE_categoryName___FilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: ___VARIABLE_categoryName___ViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    func onCategoryAction(_ action: ___VARIABLE_categoryName___ListContentView.Action) async {
        switch action {
        case let .onTapItem(category):
            await onTapDetail___VARIABLE_categoryName___(category)
        case let .onTapEditCategory(category):
            await onTapEdit___VARIABLE_categoryName___(category)
        case let .onTapToggleFavorite(category):
            await onTapToggleFavorite(category)
        case let .onTapDuplicateCategory(category):
            await onTapDuplicate___VARIABLE_categoryName___(category)
        case let .onTapDeleteCategory(category):
            await onTapDelete___VARIABLE_categoryName___(category)
        }
    }
}

// MARK: - Internal methods

private extension ___VARIABLE_categoryName___ListViewModel {
    func onTapDelete___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.___VARIABLE_modelVariableName___CategoryStorageService.delete(category)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetchData()
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapEdit___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        logUI("Edit action triggered for ___VARIABLE_categoryName___: \(category.name)")
        await state.update {
            $0.destination = .___VARIABLE_modelVariableName___CategoryEdit(
                category,
                onSave: { _ in
                    Task {
                        logSuccess("___VARIABLE_categoryName___ edit completed: \(category.name)")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapToggleFavorite(_ category: ___VARIABLE_categoryName___) async {
        let wasFavorite = category.isFavorite
        do {
            _ = try await ___VARIABLE_modelVariableName___CategoryStorageService.toggleFavorite(category)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapDuplicate___VARIABLE_categoryName___(_ category: ___VARIABLE_categoryName___) async {
        do {
            _ = try await ___VARIABLE_modelVariableName___CategoryStorageService.duplicate(category)
            await state.update { $0.hud = .success("Duplicated") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func fetchSearchedCategories(searchTerm: String) async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let categories = try await ___VARIABLE_modelVariableName___CategoryStorageService.search(
                query: searchTerm,
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            if categories.isEmpty {
                await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .searchEmpty(query: searchTerm) }
            } else {
                await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .searchResult(query: searchTerm, result: categories) }
            }

        } catch {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
        }
    }

    func fetchData() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let categories = try await ___VARIABLE_modelVariableName___CategoryStorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            if categories.isEmpty {
                await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .empty }
            } else {
                await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .result(categories) }
            }
        } catch {
            await state.update { $0.___VARIABLE_categoryPluralVariableName___State = .error(error) }
        }
    }
}