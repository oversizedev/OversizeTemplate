//
// Copyright © 2025 Alexander Romanov
// MainView.swift, created on 27.04.2025
//

import Env
import Foundation
import OversizeRouter
import SwiftUI

public struct RootView: View {
    public init() {}

    public var body: some View {
        RoutingTabView(
            selection: .main,
            tabs: [
                MainTab.main,
                MainTab.settings,
            ]
        )
    }
}
