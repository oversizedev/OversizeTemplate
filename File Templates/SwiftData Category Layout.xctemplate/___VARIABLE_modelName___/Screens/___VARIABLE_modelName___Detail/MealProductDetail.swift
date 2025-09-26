//
// Copyright © 2025 Alexander Romanov
// MealProductDetail.swift, created on 19.09.2025
//

import Database
import Foundation
import OversizeArchitecture

@Module
public enum MealProductDetail: ModuleProtocol {}

public struct MealProductDetailInput: Sendable {
    public let source: Source

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

    public var mealProductId: UUID {
        switch source {
        case let .id(id):
            id
        case let .mealProduct(mealProduct):
            mealProduct.id
        }
    }
}

public struct MealProductDetailOutput: Sendable {
    public let onEdit: (@Sendable (MealProduct) -> Void)?
    public let onDelete: (@Sendable (MealProduct) -> Void)?

    public init(
        onEdit: (@Sendable (MealProduct) -> Void)? = nil,
        onDelete: (@Sendable (MealProduct) -> Void)? = nil
    ) {
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
}