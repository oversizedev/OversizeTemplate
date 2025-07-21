// ___FILEHEADER___

import Database
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension MealProductDetailViewModel {
    enum InputEvent {
        case onAppear
        case onRefresh
        case onTapEditMealProduct
        case onTapDeleteMealProduct
    }
}

public actor MealProductDetailViewModel {
    /// ViewState
    public var state: MealProductDetailViewState

    /// Initialization
    public init(state: MealProductDetailViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onRefresh:
            await onRefresh()
        case .onTapDeleteMealProduct:
            await deleteMealProduct()
        case .onTapEditMealProduct:
            await onEdit()
        }
    }
}

// MARK: - User Actions

public extension MealProductDetailViewModel {
    func onAppear() async {
        if await state.mealProductState.result == nil {
            await fetchData()
        }
    }

    func onRefresh() async {
        await fetchData(force: true)
    }

    func onEdit() async {
        await state.update {
            $0.destination = .mealProductEdit(id: $0.mealProductId)
        }
    }

    private func deleteMealProduct() async {
        await state.update { viewState in
            viewState.alert = .delete {
                logDeleted("MealProduct")
                viewState.isDismissed = true
            }
        }
    }
}

// MARK: - Data Fetching

public extension MealProductDetailViewModel {
    private func fetchData(force _: Bool = false) async {
        let result = await fetchMealProduct()
        switch result {
        case let .success(mealProduct):
            await state.update {
                $0.mealProductState = .result(mealProduct)
            }
        case let .failure(error):
            await state.update {
                $0.mealProductState = .error(error)
            }
        }
    }

    private func fetchMealProduct() async -> Result<MealProduct, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}
