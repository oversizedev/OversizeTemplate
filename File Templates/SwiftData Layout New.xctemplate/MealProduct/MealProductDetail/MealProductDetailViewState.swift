 // ___FILEHEADER___

import Database
import Environment
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class MealProductDetailViewState: Sendable {
    // User Interface
    public var mealProductState: LoadingViewState<MealProduct> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    // Routing
    public var destination: MealProductDestinations?
    public var alert: AppAlert?
    public var isDismissed: Bool = false

    // Static
    public let mealProductId: UUID

    // Initialization
    public init(mealProductId: UUID) {
        self.mealProductId = mealProductId
    }

    public init(mealProduct: MealProduct) {
        mealProductId = mealProduct.id
        mealProductState = .result(mealProduct)
    }
}

// MARK: - User Actions

public extension MealProductDetailViewState {
    func update(_ handler: @Sendable @MainActor (MealProductDetailViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
}
