//___FILEHEADER___

import OversizeComponents
import OversizeKit
import SwiftUI

enum Screen {
    case settings
    case premium
    case webView(url: URL)
}

extension Screen: Identifiable {
    var id: String {
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

    func resolveSheet(
        pathItem: Screen,
        detents: Set<PresentationDetent>,
        dragIndicator: Visibility = .automatic,
        dismissDisabled: Bool
    ) -> some View {
        resolve(pathItem: pathItem)
            .presentationDetents(detents)
            .presentationDragIndicator(dragIndicator)
            .interactiveDismissDisabled(dismissDisabled)
    }
}
