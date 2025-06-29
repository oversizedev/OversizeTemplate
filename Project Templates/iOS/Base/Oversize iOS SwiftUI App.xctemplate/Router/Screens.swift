//___FILEHEADER___

import OversizeModels
import SwiftUI

public enum Screen {
    case settings
    case premium
    case webView(url: URL)
}

extension Screen: Identifiable {
    public var id: String {
        switch self {
        case .settings:
            return "settings"
        case .premium:
            return "premium"
        case .webView:
            return "webView"
        }
    }
}
