//
// Copyright © 2025 Alexander Romanov
// MealProductDestinations.swift, created on 25.09.2025
//  

import Database
import OversizeCore
import OversizeNavigation
import SwiftUI

public enum MealProductDestinations {
    case mealProductsList
    case mealProductsArchive
    case mealProductsFavorites
    case mealProductDetails(id: UUID)
    case mealProductDetailsMealProduct(mealProduct: MealProduct)
    case mealProductCreate(callback: Callback<MealProductEditViewState.CallbackAction>? = nil)
    case mealProductEditId(id: UUID, callback: Callback<MealProductEditViewState.CallbackAction>? = nil)
    case mealProductEdit(_ mealProduct: MealProduct, callback: Callback<MealProductEditViewState.CallbackAction>? = nil)
    case mealProductCategoriesList
    case mealProductCategoryDetails(id: UUID)
    case mealProductCategoryDetailsMealProductCategory(mealProductCategory: MealProductCategory)
    case mealProductCategoryCreate(callback: Callback<MealProductCategoryEditViewState.CallbackAction>? = nil)
    case mealProductCategoryEditId(id: UUID, callback: Callback<MealProductCategoryEditViewState.CallbackAction>? = nil)
    case mealProductCategoryEdit(_ mealProductCategory: MealProductCategory, callback: Callback<MealProductCategoryEditViewState.CallbackAction>? = nil)
}

extension MealProductDestinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .mealProductsList:
            MealProductListScreen.build()
        case .mealProductsArchive:
            MealProductListScreen.buildArchive()
        case .mealProductsFavorites:
            MealProductListScreen.buildFavorites()
        case let .mealProductDetails(id):
            MealProductDetailScreen.build(id: id)
        case let .mealProductDetailsMealProduct(mealProduct: mealProduct):
            MealProductDetailScreen.build(mealProduct: mealProduct)
        case let .mealProductCreate(callback):
            MealProductEditScreen.build(handler: callback)
        case let .mealProductEditId(id: id, callback: callback):
            MealProductEditScreen.buildEdit(id: id, handler: callback)
        case let .mealProductEdit(mealProduct, callback: callback):
            MealProductEditScreen.buildEdit(mealProduct: mealProduct, handler: callback)
        case .mealProductCategoriesList:
            MealProductCategoryListScreen.build()
        case let .mealProductCategoryDetails(id):
            MealProductCategoryDetailScreen.build(id: id)
        case let .mealProductCategoryDetailsMealProductCategory(mealProductCategory: mealProductCategory):
            MealProductCategoryDetailScreen.build(mealProductCategory: mealProductCategory)
        case let .mealProductCategoryCreate(callback):
            MealProductCategoryEditScreen.build(handler: callback)
        case let .mealProductCategoryEditId(id: id, callback: callback):
            MealProductCategoryEditScreen.buildEdit(id: id, handler: callback)
        case let .mealProductCategoryEdit(mealProductCategory, callback: callback):
            MealProductCategoryEditScreen.buildEdit(mealProductCategory: mealProductCategory, handler: callback)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .mealProductCreate, .mealProductEdit, .mealProductEditId,
             .mealProductCategoryCreate, .mealProductCategoryEdit, .mealProductCategoryEditId:
            .managedSheet
        default:
            .push
        }
    }
}