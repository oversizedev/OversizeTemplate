// ___FILEHEADER___

import Database
import NavigatorUI
import SwiftUI

public enum MealProductDestinations {
    case mealProductsList
    case mealProductDetails(id: UUID)
    case mealProductDetailsMealProduct(mealProduct: MealProduct)
    case mealProductCreate
    case mealProductEdit(id: UUID)
    case mealProductEditMealProduct(mealProduct: MealProduct)
}

extension MealProductDestinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .mealProductsList:
            MealProductListScreen.build()
        case let .mealProductDetails(id):
            MealProductDetailScreen.build(id: id)
        case let .mealProductDetailsMealProduct(mealProduct: mealProduct):
            MealProductDetailScreen.build(mealProduct: mealProduct)
        case .mealProductCreate:
            MealProductEditScreen.build()
        case let .mealProductEdit(id: id):
            MealProductEditScreen.buildEdit(id: id)
        case let .mealProductEditMealProduct(mealProduct: mealProduct):
            MealProductEditScreen.buildEdit(mealProduct: mealProduct)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .mealProductCreate, .mealProductEdit, .mealProductEditMealProduct:
            .managedSheet
        default:
            .push
        }
    }
}

public struct MealProductRootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            MealProductListScreen.build()
                .navigationDestinationAutoReceive(MealProductDestinations.self)
        }
        .systemServices()
    }
}
