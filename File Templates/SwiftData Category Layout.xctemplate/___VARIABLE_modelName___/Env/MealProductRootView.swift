//
// Copyright © 2025 Alexander Romanov
// MealProductRootView.swift, created on 25.09.2025
//  

import NavigatorUI
import SwiftUI

public struct MealProductRootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            MealProductListScreen.build()
                .navigationDestinationAutoReceive(MealProductDestinations.self)
        }
        .coreServices()
    }
}

public struct MealProductCategoryRootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            MealProductCategoryListScreen.build()
                .navigationDestinationAutoReceive(MealProductDestinations.self)
        }
        .coreServices()
    }
}