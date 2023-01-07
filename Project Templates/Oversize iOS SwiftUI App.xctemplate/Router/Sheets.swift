//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeKit
import SwiftUI

enum Sheet {
    case settings
    case premium
}

extension Sheet: Identifiable {
    var id: String {
        switch self {
        case .settings:
            return "settings"
        case .premium:
            return "premium"
        }
    }
}

extension Router {
    func resolveSheet(sheet: Sheet) -> some View {
        Group {
            switch sheet {
            case .settings:
                SettingsView {
                    AppSettingsView()
                }
            case .premium:
                StoreView()
            }
        }
        .systemServices()
    }
}
