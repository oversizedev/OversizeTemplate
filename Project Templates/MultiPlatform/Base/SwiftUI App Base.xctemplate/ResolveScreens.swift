//
// Copyright © 2024 Alexander Romanov
// ResolveRouter.swift, created on 04.07.2024
//

import App
import Env
import OversizeKit
import OversizeRouter
import SwiftUI

extension Screen: @retroactive RoutableView {
    public func view() -> some View {
        switch self {
        case .main:
            Text("Main")
        }
    }
}
