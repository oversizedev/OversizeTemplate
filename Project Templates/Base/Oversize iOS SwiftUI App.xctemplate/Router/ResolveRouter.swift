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

