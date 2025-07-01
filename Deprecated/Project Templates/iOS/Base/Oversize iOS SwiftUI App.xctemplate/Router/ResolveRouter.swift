//___FILEHEADER___

import OversizeComponents
import OversizeKit
import SwiftUI

extension Router {
    @ViewBuilder
    func resolve(pathItem: Screen) -> some View {
        switch pathItem {
        case .settings:
            SettingsView {
                AppSettingsView()
            }
        case .premium:
            StoreView()
        case let .webView(url: url):
            WebView(url: url)
        }
    }
}

