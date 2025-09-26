//
// Copyright © 2025 Alexander Romanov
// MealProductListViewModel.swift, created on 10.07.2025
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

@ViewModel(module: MealProductList.self)
public actor MealProductListViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.mealProductStorageService) var mealProductStorageService: MealProductStorageService
    @Injected(\.mealProductCategoryStorageService) var mealProductCategoryStorageService: MealProductCategoryStorageService

    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData()
    }

    func onChangeSearchTerm(_ searchTerm: String) async {
        if searchTerm.isEmpty {
            await fetchMealProducts()
        } else {
            await fetchSearchedMealProducts(searchTerm: searchTerm)
        }
    }

    func onTapSearch() async {
        await state.update { $0.isSearch.toggle() }
    }

    func onTapCreateMealProduct() async {
        await state.update { viewState in
            viewState.destination = .mealProductCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New MealProduct created")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDisplayType(_ displayType: MealProductListDisplayType) async {
        await state.update { $0.storage.displayType = displayType }
    }

    func onTapDetailMealProduct(_ mealProduct: MealProduct) async {
        await state.update { $0.destination = .mealProductDetailsMealProduct(mealProduct: mealProduct) }
    }

    func onChangeSortType(_ sortType: MealProductSortType) async {
        await state.update { $0.storage.sortType = sortType }
        await fetchMealProducts()
    }

    func onChangeSortOrder(_ sortOrder: MealProductSortOrder) async {
        await state.update { $0.storage.sortOrder = sortOrder }
        await fetchMealProducts()
    }

    func onChangeFilterType(_ filterType: MealProductFilterType) async {
        await state.update { $0.filterType = filterType }
        await fetchMealProducts()
    }

    func onToggleCompactView() async {
        await state.update { $0.storage.isCompactRow.toggle() }
    }

    func onChangeViewOption(_ viewOption: MealProductViewOption) async {
        await state.update { $0.storage.viewOption = viewOption }
    }

    private func onTapDeleteMealProduct(_ mealProduct: MealProduct) async {
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    do {
                        try await self.mealProductStorageService.delete(mealProduct)
                        await self.state.update { $0.hud = .delete() }
                        await self.fetchMealProducts()
                    } catch {
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    private func onTapEditMealProduct(_ mealProduct: MealProduct) async {
        logUI("Edit action triggered for MealProduct: \(mealProduct.name)")
        await state.update {
            $0.destination = .mealProductEdit(
                mealProduct,
                onSave: { _ in
                    Task {
                        logSuccess("MealProduct edit completed: \(mealProduct.name)")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    private func onTapToggleFavorite(_ mealProduct: MealProduct) async {
        let wasFavorite = mealProduct.isFavorite
        do {
            _ = try await mealProductStorageService.toggleFavorite(mealProduct)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchMealProducts()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapDuplicateMealProduct(_ mealProduct: MealProduct) async {
        do {
            _ = try await mealProductStorageService.duplicate(mealProduct)
            await state.update { $0.hud = .success("Duplicated") }
            await fetchMealProducts()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapSelectCategory(_ mealProduct: MealProduct, _ category: MealProductCategory?) async {
        do {
            _ = try await mealProductStorageService.updateCategory(mealProduct, categoryId: category?.id)
            await state.update { $0.hud = category != nil ? .success("Category assigned") : .success("Category removed") }
            await fetchMealProducts()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    private func onTapCreateCategoryForProduct(_ mealProduct: MealProduct) async {
        await state.update { viewState in
            viewState.destination = .mealProductCategoryCreate(
                onSave: { _ in
                    Task {
                        logSuccess("New Category created, fetching categories")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onProductAction(_ action: MealProductListContentView.Action) async {
        switch action {
        case let .tapItem(product):
            await onTapDetailMealProduct(product)
        case let .editProduct(product):
            await onTapEditMealProduct(product)
        case let .toggleFavorite(product):
            await onTapToggleFavorite(product)
        case let .duplicateProduct(product):
            await onTapDuplicateMealProduct(product)
        case let .deleteProduct(product):
            await onTapDeleteMealProduct(product)
        case let .selectCategory(product, category):
            await onTapSelectCategory(product, category)
        case let .createCategoryForProduct(product):
            await onTapCreateCategoryForProduct(product)
        }
    }
}

public extension MealProductListViewModel {
    func fetchData() async {
        await fetchMealProducts()
        await fetchCategories()
    }

    func fetchSearchedMealProducts(searchTerm: String) async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let products = try await mealProductStorageService.search(
                query: searchTerm,
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder
            )

            if products.isEmpty {
                await state.update { $0.mealProductsState = .searchEmpty(query: searchTerm) }
            } else {
                await state.update { $0.mealProductsState = .searchResult(query: searchTerm, result: products) }
            }

        } catch {
            await state.update { $0.mealProductsState = .error(error) }
        }
    }

    func fetchMealProducts() async {
        let sortType = await state.storage.sortType
        let sortOrder = await state.storage.sortOrder
        let filterType = await state.filterType

        do {
            let products = try await mealProductStorageService.fetch(
                filterType: filterType,
                sortType: sortType,
                sortOrder: sortOrder,
                categoryId: input?.categoryId
            )

            if products.isEmpty {
                await state.update { $0.mealProductsState = .empty }
            } else {
                await state.update { $0.mealProductsState = .result(products) }
            }
        } catch {
            await state.update { $0.mealProductsState = .error(error) }
        }
    }

    func fetchCategories() async {
        do {
            let categories = try await mealProductCategoryStorageService.fetch()
            await state.update { $0.categoriesState = .result(categories) }
        } catch {
            await state.update { $0.categoriesState = .error(error) }
        }
    }
}
