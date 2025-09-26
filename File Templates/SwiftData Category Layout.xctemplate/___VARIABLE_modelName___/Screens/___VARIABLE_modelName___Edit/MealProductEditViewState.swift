//
// Copyright © 2025 Alexander Romanov
// MealProductEditViewState.swift, created on 10.07.2025
//

import Database
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeNavigation
import SwiftUI

@Observable
public final class MealProductEditViewState: ViewStateProtocol {
    /// Forms
    public var name: String = .init()
    public var note: String = .init()
    public var color: Color = .blue
    public var url: URL?
    public var date: Date?
    #if os(macOS)
    public var image: NSImage?
    #else
    public var image: UIImage?
    #endif
    public var selectedCategory: MealProductCategory?

    /// User Interface
    public var mealProductState: LoadingState<MealProduct> = .idle
    public var categoriesState: LoadingState<[MealProductCategory]> = .idle
    public var focusedField: FocusField?
    public var isSaving: Bool = .init()
    public var isDismissed: Bool = .init()
    public var isEmptyForm: Bool = true
    public var isValidForm: Bool = false
    public var hud: OversizeNavigation.HUD?
    public var destination: MealProductDestinations?
    public var isShowCategoryPicker: Bool? = false

    /// Constants
    public let source: MealProductEditInput.Source?
    public let mealProductId: UUID

    /// View
    var title: String {
        if source == nil {
            "Create product"
        } else {
            "Edit \(mealProductState.successResult?.name ?? "")"
        }
    }

    /// Initialization
    public init(input: MealProductEdit.Input?) {
        source = input?.source

        switch input?.source {
        case let .mealProduct(mealProduct):
            mealProductId = mealProduct.id
            mealProductState = .result(mealProduct)
            setFields(mealProduct: mealProduct)
        case let .id(id):
            mealProductId = id
        case .none:
            mealProductId = UUID()
        }
    }
}

// MARK: - User Actions

public extension MealProductEditViewState {
    func setFields(mealProduct: MealProduct) {
        name = mealProduct.name
        note = mealProduct.note ?? ""
        color = mealProduct.color
        date = mealProduct.date
        if let data = mealProduct.imageData {
            #if os(macOS)
            image = NSImage(data: data)
            #else
            image = UIImage(data: data)
            #endif
        }
        if let categoryId = mealProduct.categoryId {
            selectedCategory = categoriesState.successResult?.first { $0.id == categoryId }
        } else {
            selectedCategory = nil
        }
    }

    func setCategories(_ categories: [MealProductCategory]) {
        if let currentCategoryId = selectedCategory?.id {
            selectedCategory = categories.first { $0.id == currentCategoryId }
        }
    }
}

// MARK: - Supporting types

public extension MealProductEditViewState {
    /// FocusFields
    enum FocusField: String, Hashable, Sendable {
        case name, note, url
    }
}
