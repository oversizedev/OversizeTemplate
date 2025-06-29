//___FILEHEADER___

import SwiftUI

public enum RootTab: String {
    case main
    case secondary
    case tertiary
    case quaternary
    case settings

    public var id: String {
        switch self {
        case .main:
            return "home"
        case .secondary:
            return "secondary"
        case .tertiary:
            return "tertiary"
        case .quaternary:
            return "quaternary"
        case .settings:
            return "settings"
        }
    }

    public var title: String {
        switch self {
        case .main:
            return "Home"
        case .secondary:
            return "Secondary"
        case .tertiary:
            return "Tertiary"
        case .quaternary:
            return "Quaternary"
        case .settings:
            return "Settings"
        }
    }
}
