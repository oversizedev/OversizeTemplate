//
// Copyright © 2025 Alexander Romanov
// MealProductListRouter.swift, created on 10.07.2025
//

import Database
import Env
import NavigatorUI
import OversizeNavigation
import SwiftUI

extension MealProductDestinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .mealProductsList:
            MealProductList.build()
        case let .mealProductDetails(id):
            MealProductDetail.build(input: MealProductDetailInput(id: id))
        case let .mealProductDetailsMealProduct(mealProduct: mealProduct):
            MealProductDetail.build(input: MealProductDetailInput(mealProduct: mealProduct))
        case let .mealProductCreate(onSave: onSave):
            MealProductEdit.build(input: MealProductEditInput(), output: MealProductEditOutput(onSave: onSave))
        case let .mealProductEditId(id: id, onSave: onSave):
            MealProductEdit.build(input: MealProductEditInput(id: id), output: MealProductEditOutput(onSave: onSave))
        case let .mealProductEdit(mealProduct, onSave: onSave):
            MealProductEdit.build(input: MealProductEditInput(mealProduct: mealProduct), output: MealProductEditOutput(onSave: onSave))
        case .mealProductCategoriesList:
            MealProductCategoryList.build()
        case let .mealProductCategoryDetails(id):
            MealProductCategoryDetail.build(input: MealProductCategoryDetailInput(id: id))
        case let .mealProductCategoryDetailsMealProductCategory(mealProductCategory: mealProductCategory):
            MealProductCategoryDetail.build(input: MealProductCategoryDetailInput(category: mealProductCategory))
        case let .mealProductCategoryCreate(onSave: onSave):
            MealProductCategoryEdit.build(input: MealProductCategoryEditInput(), output: MealProductCategoryEditOutput(onSave: onSave))
        case let .mealProductCategoryEditId(id: id, onSave: onSave):
            MealProductCategoryEdit.build(input: MealProductCategoryEditInput(id: id), output: MealProductCategoryEditOutput(onSave: onSave))
        case let .mealProductCategoryEdit(mealProductCategory, onSave: onSave):
            MealProductCategoryEdit.build(input: MealProductCategoryEditInput(category: mealProductCategory), output: MealProductCategoryEditOutput(onSave: onSave))
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .mealProductCreate, .mealProductEdit, .mealProductEditId, .mealProductCategoryCreate, .mealProductCategoryEdit, .mealProductCategoryEditId:
            .managedSheet
        default:
            .push
        }
    }
}

extension MealProductDestinations: Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .mealProductsList:
            hasher.combine("mealProductsList")
        case let .mealProductDetails(id):
            hasher.combine("mealProductDetails")
            hasher.combine(id)
        case let .mealProductDetailsMealProduct(mealProduct):
            hasher.combine("mealProductDetailsMealProduct")
            hasher.combine(mealProduct.id)
        case .mealProductCreate:
            hasher.combine("mealProductCreate")
        case let .mealProductEditId(id, _):
            hasher.combine("mealProductEditId")
            hasher.combine(id)
        case let .mealProductEdit(mealProduct, _):
            hasher.combine("mealProductEdit")
            hasher.combine(mealProduct.id)
        case .mealProductCategoriesList:
            hasher.combine("mealProductCategoriesList")
        case let .mealProductCategoryDetails(id):
            hasher.combine("mealProductCategoryDetails")
            hasher.combine(id)
        case let .mealProductCategoryDetailsMealProductCategory(mealProductCategory):
            hasher.combine("mealProductCategoryDetailsMealProductCategory")
            hasher.combine(mealProductCategory.id)
        case .mealProductCategoryCreate:
            hasher.combine("mealProductCategoryCreate")
        case let .mealProductCategoryEditId(id, _):
            hasher.combine("mealProductCategoryEditId")
            hasher.combine(id)
        case let .mealProductCategoryEdit(mealProductCategory, _):
            hasher.combine("mealProductCategoryEdit")
            hasher.combine(mealProductCategory.id)
        }
    }

    public static func == (lhs: MealProductDestinations, rhs: MealProductDestinations) -> Bool {
        switch (lhs, rhs) {
        case (.mealProductsList, .mealProductsList):
            return true
        case let (.mealProductDetails(lhsId), .mealProductDetails(rhsId)):
            return lhsId == rhsId
        case let (.mealProductDetailsMealProduct(lhsMealProduct), .mealProductDetailsMealProduct(rhsMealProduct)):
            return lhsMealProduct.id == rhsMealProduct.id
        case (.mealProductCreate, .mealProductCreate):
            return true
        case let (.mealProductEditId(lhsId, _), .mealProductEditId(rhsId, _)):
            return lhsId == rhsId
        case let (.mealProductEdit(lhsMealProduct, _), .mealProductEdit(rhsMealProduct, _)):
            return lhsMealProduct.id == rhsMealProduct.id
        case (.mealProductCategoriesList, .mealProductCategoriesList):
            return true
        case let (.mealProductCategoryDetails(lhsId), .mealProductCategoryDetails(rhsId)):
            return lhsId == rhsId
        case let (.mealProductCategoryDetailsMealProductCategory(lhsCategory), .mealProductCategoryDetailsMealProductCategory(rhsCategory)):
            return lhsCategory.id == rhsCategory.id
        case (.mealProductCategoryCreate, .mealProductCategoryCreate):
            return true
        case let (.mealProductCategoryEditId(lhsId, _), .mealProductCategoryEditId(rhsId, _)):
            return lhsId == rhsId
        case let (.mealProductCategoryEdit(lhsCategory, _), .mealProductCategoryEdit(rhsCategory, _)):
            return lhsCategory.id == rhsCategory.id
        default:
            return false
        }
    }
}
