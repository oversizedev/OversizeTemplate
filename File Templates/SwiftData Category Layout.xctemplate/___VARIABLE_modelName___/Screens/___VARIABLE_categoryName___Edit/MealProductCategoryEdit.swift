//
// Copyright © 2025 Alexander Romanov
// MealProductCategoryEdit.swift, created on 19.09.2025
//

import Database
import Foundation
import OversizeArchitecture

@Module
public enum MealProductCategoryEdit: ModuleProtocol {}

public struct MealProductCategoryEditInput: Sendable {
    public let source: Source?

    public enum Source: Sendable {
        case id(UUID)
        case category(MealProductCategory)
    }

    public init(id: UUID) {
        source = .id(id)
    }

    public init(category: MealProductCategory) {
        source = .category(category)
    }

    public init() {
        source = nil
    }

    public var categoryId: UUID? {
        switch source {
        case let .id(id):
            id
        case let .category(category):
            category.id
        case .none:
            nil
        }
    }
}

public struct MealProductCategoryEditOutput: Sendable {
    public let onSave: (@Sendable (MealProductCategory) -> Void)?

    public init(onSave: (@Sendable (MealProductCategory) -> Void)? = nil) {
        self.onSave = onSave
    }
}
