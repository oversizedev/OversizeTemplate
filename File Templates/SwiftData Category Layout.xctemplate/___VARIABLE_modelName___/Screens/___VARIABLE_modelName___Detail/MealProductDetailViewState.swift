//
// Copyright © 2025 Alexander Romanov
// MealProductDetailViewState.swift, created on 10.07.2025
//

import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class MealProductDetailViewState: ViewStateProtocol {
    // User Interface
    public var mealProductState: LoadingState<MealProduct> = .idle
    public var categoriesState: LoadingState<[MealProductCategory]> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    // Routing
    public var destination: MealProductDestinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Static
    public let mealProductId: UUID

    // Initialization
    public init(input: MealProductDetail.Input?) {
        guard let input else {
            mealProductId = UUID()
            return
        }

        switch input.source {
        case let .mealProduct(mealProduct):
            mealProductId = mealProduct.id
            mealProductState = .result(mealProduct)
        case let .id(id):
            mealProductId = id
            mealProductState = .loading
        }
    }
}
