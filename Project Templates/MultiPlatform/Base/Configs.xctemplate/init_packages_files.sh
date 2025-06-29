# Create Swift files in App package
rm -rf Packages/Env/Sources/Env/Env.swift
touch Packages/Env/Sources/Env/MainTabs.swift
cat <<EOF >Packages/Env/Sources/Env/MainTabs.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// Tabs.swift, created on $(date +%d.%m.%Y)
//

import OversizeResources
import OversizeRouter
import SwiftUI

public enum MainTab: Tabable {
    public static let allCases: [MainTab] = [MainTab.main, MainTab.settings]

    case main
    case settings
}

public extension MainTab {
    var icon: Image {
        switch self {
        case .main:
            Image.GridsAndLayout.grid
        case .settings:
            Image.Base.setting2
        }
    }

    var title: String {
        switch self {
        case .main:
            .init("Main")
        case .settings:
            .init("Settings")
        }
    }

    var id: String {
        switch self {
        case .main:
            "main"
        case .settings:
            "settings"
        }
    }
}
EOF

touch Packages/Env/Sources/Env/Screens.swift
cat <<EOF >Packages/Env/Sources/Env/Screens.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// AccountListRouter.swift, created on $(date +%d.%m.%Y)
//

import OversizeRouter
import SwiftUI

public enum Screen: Routable {
    case main
}

public extension Screen {
    var id: String {
        switch self {
        case .main:
            "main"
        }
    }
}
EOF
