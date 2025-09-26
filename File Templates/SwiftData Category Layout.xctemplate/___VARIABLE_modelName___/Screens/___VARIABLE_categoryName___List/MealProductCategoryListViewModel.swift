//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryListViewModel.swift, created on 27.07.2025
//

import Database
import FactoryKit
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

@ViewModel(module: MealProductCategoryList.self)
public actor MealProductCategoryListViewModel: ViewModelProtocol {
    // MARK: - Services

    @Injected(\.mealProductCategoryStorageService) var mealProductCategoryStorageService: MealProductCategoryStorageService

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

    func onTapCreateMealProductCategory() async {
        await state.update { viewState in
            viewState.destination = .mealProductCategoryCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New MealProductCategory created")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDisplayType(_ displayType: MealProductCategoryListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetailMealProductCategory(_ category: MealProductCategory) async {
        await state.update { $0.destination = .mealProductCategoryDetailsMealProductCategory(mealProductCategory: category) }
    }

    func onChangeSortType(_ sortType: MealProductCategorySortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchData()
    }

    func onChangeSortOrder(_ sortOrder: MealProductCategorySortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchData()
    }

    func onChangeFilterType(_ filterType: MealProductCategoryFilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchData()
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: MealProductCategoryViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    func onCategoryAction(_ action: MealProductCategoryListContentView.Action) async {
        switch action {
        case let .onTapItem(category):
            await onTapDetailMealProductCategory(category)
        case let .onTapEditCategory(category):
            await onTapEditMealProductCategory(category)
        case let .onTapToggleFavorite(category):
            await onTapToggleFavorite(category)
        case let .onTapDuplicateCategory(category):
            await onTapDuplicateMealProductCategory(category)
        case let .onTapDeleteCategory(category):
            await onTapDeleteMealProductCategory(category)
        }
    }
}

// MARK: - Internal methods

private extension MealProductCategoryListViewModel {
    func onTapDeleteMealProductCategory(_ category: MealProductCategory) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.mealProductCategoryStorageService.delete(category)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetchData()
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapEditMealProductCategory(_ category: MealProductCategory) async {
        logUI("Edit action triggered for MealProductCategory: \(category.name)")
        await state.update {
            $0.destination = .mealProductCategoryEdit(
                category,
                onSave: { _ in
                    Task {
                        logSuccess("MealProductCategory edit completed: \(category.name)")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapToggleFavorite(_ category: MealProductCategory) async {
        let wasFavorite = category.isFavorite
        do {
            _ = try await mealProductCategoryStorageService.toggleFavorite(category)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapDuplicateMealProductCategory(_ category: MealProductCategory) async {
        do {
            _ = try await mealProductCategoryStorageService.duplicate(category)
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
            let categories = try await mealProductCategoryStorageService.search(
                query: searchTerm,
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            if categories.isEmpty {
                await state.update { $0.mealProductCategoriesState = .searchEmpty(query: searchTerm) }
            } else {
                await state.update { $0.mealProductCategoriesState = .searchResult(query: searchTerm, result: categories) }
            }

        } catch {
            await state.update { $0.mealProductCategoriesState = .error(error) }
        }
    }

    func fetchData() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let categories = try await mealProductCategoryStorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            if categories.isEmpty {
                await state.update { $0.mealProductCategoriesState = .empty }
            } else {
                await state.update { $0.mealProductCategoriesState = .result(categories) }
            }
        } catch {
            await state.update { $0.mealProductCategoriesState = .error(error) }
        }
    }
}
