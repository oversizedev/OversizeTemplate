// ___FILEHEADER___

import Database
import FactoryKit
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftData
import SwiftUI

extension MealProductListViewModel {
    enum InputEvent {
        case onAppear
        case onRefresh
        case onTapSearch
        case onTapCreateMealProduct
        case onTapDetailMealProduct(_ mealProduct: MealProduct)
        case onTapDeleteMealProduct(_ mealProduct: MealProduct)
        case onTapDisplayType(_ displayType: MealProductListDisplayType)
        case onChangeSearchTerm(oldValue: String, newValue: String)
    }
}

public actor MealProductListViewModel {
    /// Services
    /// @Injected(\.service) var service

    /// ViewState
    public var state: MealProductListViewState

    /// Initialization
    public init(state: MealProductListViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapSearch:
            await onTapSearch()
        case let .onChangeSearchTerm(oldValue: oldValue, newValue: newValue):
            await onChangeSearchTerm(oldValue: oldValue, newValue: newValue)
        case let .onTapDeleteMealProduct(mealProduct):
            await deleteMealProduct(mealProduct)
        case let .onTapDisplayType(displayType):
            await onTapDisplayType(displayType)
        case let .onTapDetailMealProduct(mealProduct):
            await onTapDetailMealProduct(mealProduct)
        case .onTapCreateMealProduct:
            await onCreate()
        }
    }
}

// MARK: - User Actions

public extension MealProductListViewModel {
    func onAppear() async {
        await fetchData()
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onChangeSearchTerm(oldValue _: String, newValue _: String) async {}

    func onTapSearch() async {
        await state.update {
            $0.isSearch.toggle()
        }
    }

    func onCreate() async {
        await state.update {
            $0.destination = .mealProductcreate
        }
    }

    func onTapDisplayType(_ displayType: MealProductListDisplayType) async {
        await state.update {
            $0.storage.displayType = displayType
        }
    }

    func onTapDetailMealProduct(_ mealProduct: MealProduct) async {
        await state.update {
            $0.destination = .mealProductDetailsMealProduct(mealProduct: mealProduct)
        }
    }

    private func deleteMealProduct(_ mealProduct: MealProduct) async {
        await state.update {
            $0.alert = .delete {
                logDeleted("MealProduct \(mealProduct.name)")
            }
        }
    }
}

// MARK: - Data Fetching

extension MealProductListViewModel {
    private func fetchData(force _: Bool = false) async {
        let result = await fetchMealProduct()
        switch result {
        case let .success(mealProducts):
            await state.update {
                $0.mealProductsState = .result(mealProducts)
            }
        case let .failure(error):
            await state.update {
                $0.mealProductsState = .error(error)
            }
        }
    }

    private func fetchMealProduct() async -> Result<[MealProduct], AppError> {
        .success([
            .init(id: UUID(), name: "MealProduct 1", color: Color.red, date: Date()),
        ])
    }
}
