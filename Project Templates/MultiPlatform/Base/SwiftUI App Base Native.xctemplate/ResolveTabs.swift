//
// Copyright © 2025 Alexander Romanov
// ResolveTabs.swift, created on 27.04.2025
//

import App
import Env
import Foundation
import OversizeKit
import OversizeRouter
import SwiftUI

extension MainTab: @retroactive TabableView {
    public func view() -> some View {
        switch self {
        case .main:
            RoutingView<Text, Screen> {
                Text("Root")
            }
            .systemServices()
        case .settings:
            SettingsRoutingView()
        }
    }
}
