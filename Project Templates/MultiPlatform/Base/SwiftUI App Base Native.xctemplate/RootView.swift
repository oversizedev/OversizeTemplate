//
// Copyright © 2025 Alexander Romanov
// MainView.swift, created on 27.04.2025
//

import Env
import Foundation
import OversizeNavigation
import SwiftUI

public struct RootView: View {
    public init() {}

    public var body: some View {
        RoutingView<Text, Screen> {
            Text("Root")
        }
        .systemServices()
    }
}
