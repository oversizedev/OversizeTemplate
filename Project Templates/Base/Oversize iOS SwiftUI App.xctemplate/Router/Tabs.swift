//___FILEHEADER___

import SwiftUI

public enum RootTab: String {
    case main
    case secondary
    case tertiary
    case quaternary
    case settings

    var id: String {
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

    var title: String {
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
    
    var image: Image {
        switch self {
        case .main:
            return Image(systemName: "")
        case .secondary:
            return Image(systemName: "")
        case .tertiary:
            return Image(systemName: "")
        case .quaternary:
            return Image(systemName: "")
        case .settings:
            return Image(systemName: "")
        }
    }
}
