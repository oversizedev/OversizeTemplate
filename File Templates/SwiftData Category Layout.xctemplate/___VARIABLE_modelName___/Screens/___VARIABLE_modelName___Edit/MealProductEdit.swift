//
// Copyright © 2025 Alexander Romanov
// MealProductEdit.swift, created on 19.09.2025
//

import Database
import Foundation
import OversizeArchitecture

@Module
public enum MealProductEdit: ModuleProtocol {}

public struct MealProductEditInput: Sendable {
    public let source: Source?

    public enum Source: Sendable {
        case id(UUID)
        case mealProduct(MealProduct)
    }

    public init(id: UUID) {
        source = .id(id)
    }

    public init(mealProduct: MealProduct) {
        source = .mealProduct(mealProduct)
    }

    public init() {
        source = nil
    }

    public var mealProductId: UUID? {
        switch source {
        case let .id(id):
            id
        case let .mealProduct(mealProduct):
            mealProduct.id
        case .none:
            nil
        }
    }
}

public struct MealProductEditOutput: Sendable {
    public let onSave: (@Sendable (MealProduct) -> Void)?

    public init(onSave: (@Sendable (MealProduct) -> Void)? = nil) {
        self.onSave = onSave
    }
}
