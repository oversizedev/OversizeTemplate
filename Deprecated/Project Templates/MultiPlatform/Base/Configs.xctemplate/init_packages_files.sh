# Create Swift files in App package
rm -rf Packages/Env/Sources/Env/Env.swift
touch Packages/Env/Sources/Env/RootTabs.swift
cat <<EOF >Packages/Env/Sources/Env/RootTabs.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// Tabs.swift, created on $(date +%d.%m.%Y)
//

import OversizeUI
import OversizeResources
import SwiftUI

public enum RootTabs: Int, Codable {
    case main
    case settings
}

extension RootTabs: Identifiable {
    public static var tabs: [RootTabs] {
        [.main, .settings]
    }

    public static var sidebar: [RootTabs] {
        [.main, .settings]
    }

    public var icon: Image {
        switch self {
        case .main:
            Image.GridsAndLayout.grid
        case .settings:
            Image.Base.setting2
        }
    }

    public var title: String {
        switch self {
        case .main:
            .init("Main")
        case .settings:
            .init("Settings")
        }
    }

    public var id: String {
        "\(self)"
    }
}

EOF

touch Packages/Env/Sources/Env/Screens.swift
cat <<EOF >Packages/Env/Sources/Env/Screens.swift
//
// Copyright © $(date +%Y) Alexander Romanov
// Screens.swift, created on $(date +%d.%m.%Y)
//

import SwiftUI

public enum Screen: Int {
    case main
}

extension Screen: Identifiable {
    public var id: String {
        "\(self)"
    }
}

EOF
