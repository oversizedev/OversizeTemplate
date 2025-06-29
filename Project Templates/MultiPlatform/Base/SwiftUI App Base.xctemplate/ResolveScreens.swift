//___FILEHEADER___

import App
import Env
import OversizeKit
import OversizeNavigation
import SwiftUI

extension Screen: @retroactive RoutableView {
    public func view() -> some View {
        switch self {
        case .main:
            Text("Main")
        }
    }
}
