// ___FILEHEADER___

import Database
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

extension MealProductEditViewModel {
    enum InputEvent {
        case onAppear
        case onTapSave
        case onFocusField(MealProductEditViewState.FocusField?)
    }
}

public actor MealProductEditViewModel {
    /// ViewState
    public var state: MealProductEditViewState

    /// Initialization
    public init(state: MealProductEditViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        case .onTapSave:
            await onSave()
        case let .onFocusField(field):
            await onFocusField(field)
        }
    }
}

// MARK: - User Actions

public extension MealProductEditViewModel {
    func onAppear() async {
        if await state.mealProductState.result == nil {
            await fetchData()
        }
        await onFocusField(.name)
    }

    func onFocusField(_ field: MealProductEditViewState.FocusField?) async {
        await state.update {
            $0.focusedField = field
        }
    }

    func onSave() async {
        guard await !state.isEmptyForm else {
            return
        }
        await state.update {
            $0.isSaving = true
        }
        
        let result = await createMealProduct()
        switch result {
        case .success:
            // Handle success - navigate back, show success message
            break
        case .failure:
            // Handle error
            await state.update {
                $0.isSaving = false
            }
        }
    }
}

// MARK: - Data Fetching

public extension MealProductEditViewModel {
    func fetchData() async {
        let result = await fetchMealProduct()
        switch result {
        case let .success(mealProduct):
            await state.update {
                $0.mealProductState = .result(mealProduct)
                $0.setFields(mealProduct: mealProduct)
            }
        case let .failure(error):
            await state.update {
                $0.mealProductState = .error(error)
            }
        }
    }

    func fetchMealProduct() async -> Result<MealProduct, AppError> {
        .failure(AppError.network(type: .unknown))
    }
    
    func createMealProduct() async -> Result<MealProduct, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}
