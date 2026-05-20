//___FILEHEADER___

import App
import Env
import OversizeKit
import SwiftUI
import OversizeRouter

extension Screen: @retroactive RoutableView {
    public func view() -> some View {
        switch self {
        case .main:
            Text("Main")
        }
    }
}

