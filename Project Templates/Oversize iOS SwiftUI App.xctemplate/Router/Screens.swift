//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeServices
import OversizeKit
import SwiftUI

enum Route {
    case settings
}

extension Route: Identifiable {
    var id: String {
        switch self {
        case .settings:
            return "settings"
        }
    }
}

extension Router {
    func resolve(pathItem: Route) -> some View {
        Group {
            switch pathItem {
            case .settings:
                SettingsView {
                    AppSettingsView()
                }
            }
        }
        .systemServices()
    }
}
