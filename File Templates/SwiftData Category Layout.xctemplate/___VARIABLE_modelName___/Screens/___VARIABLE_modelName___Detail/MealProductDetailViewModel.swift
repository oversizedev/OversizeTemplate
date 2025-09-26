//
// Copyright © 2025 Alexander Romanov
// MealProductDetailViewModel.swift, created on 10.07.2025
//

import Database
import FactoryKit
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeUI
import SwiftUI

@ViewModel(module: MealProductDetail.self)
public actor MealProductDetailViewModel: ViewModelProtocol {
    /// Services
    @Injected(\.mealProductStorageService) var mealProductStorageService: MealProductStorageService
    @Injected(\.mealProductCategoryStorageService) var mealProductCategoryStorageService: MealProductCategoryStorageService

    func onAppear() async {
        if await state.mealProductState.successResult == nil {
            await fetchData()
        } else {
            await incrementViewCount()
            await fetchCategories()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onTapEditMealProduct() async {
        guard let mealProduct = await state.mealProductState.successResult else { return }
        await state.update { viewState in
            viewState.destination = .mealProductEdit(
                mealProduct,
                onSave: { _ in
                    Task {
                        logSuccess("MealProduct edit completed")
                        await self.fetchData()
                    }
                }
            )
        }
    }

    func onTapDeleteMealProduct() async {
        guard let mealProduct = await state.mealProductState.successResult else { return }
        await state.update { viewState in
            viewState.alert = .delete {
                Task {
                    logData("Attempting to delete MealProduct: \(mealProduct.name)")
                    do {
                        try await self.mealProductStorageService.delete(mealProduct)
                        logDeleted("MealProduct")
                        await self.state.update { viewState in
                            viewState.hud = .delete
                            viewState.isDismissed = true
                        }
                    } catch {
                        logError("Failed to delete MealProduct: \(mealProduct.name)", error: error)
                        await self.state.update { $0.alert = .error(error) }
                    }
                }
            }
        }
    }

    func onTapToggleFavorite() async {
        guard let mealProduct = await state.mealProductState.successResult else {
            logWarning("Cannot toggle favorite - no MealProduct loaded")
            return
        }
        let wasFavorite = mealProduct.isFavorite

        do {
            _ = try await mealProductStorageService.toggleFavorite(mealProduct)
            await state.update { $0.hud = wasFavorite ? .unfavorite() : .favorite() }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func incrementViewCount() async {
        guard let mealProduct = await state.mealProductState.successResult else { return }
        do {
            _ = try await mealProductStorageService.incrementViewCount(mealProduct)
        } catch {
            logError("Silently failed to increment view count for MealProduct", error: error)
        }
    }

    func onTapSelectCategory(_ category: MealProductCategory?) async {
        guard let mealProduct = await state.mealProductState.successResult else {
            logWarning("Cannot select category - no MealProduct loaded")
            return
        }

        do {
            _ = try await mealProductStorageService.updateCategory(mealProduct, categoryId: category?.id)
            await state.update { $0.hud = category != nil ? .success("Category assigned") : .success("Category removed") }
            await fetchData()
        } catch {
            await state.update { $0.alert = .error(error) }
        }
    }

    func onTapCreateCategory() async {
        await state.update { viewState in
            viewState.destination = .mealProductCategoryCreate(
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

public extension MealProductDetailViewModel {
    private func fetchData() async {
        await fetchMealProduct()
        await fetchCategories()
    }

    func fetchMealProduct() async {
        do {
            let mealProduct = try await mealProductStorageService.fetch(by: state.mealProductId)
            await state.update { $0.mealProductState = .result(mealProduct) }
        } catch {
            await state.update { $0.mealProductState = .error(error) }
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
