//___FILEHEADER___

import SwiftUI

@MainActor
public final class Router: ObservableObject {
    
    // Route and Tabs
    @Published public var mainPath = NavigationPath()
    @Published public var secondaryPath = NavigationPath()
    @Published public var tertiaryPath = NavigationPath()
    @Published public var quaternaryPath = NavigationPath()
    @Published public var settingsPath = NavigationPath()
    @Published public var tab: RootTab = .main

    // Sheets
    @Published public var sheet: Screen?
    @Published public var fullScreenCover: Screen?
    @Published public var sheetDetents: Set<PresentationDetent> = []
    @Published public var dragIndicator: Visibility = .hidden
    @Published public var dismissDisabled: Bool = false

    // Hud
    @Published public var isShowHud: Bool = false
    @Published public var hudText: String = ""

    // Alert
    @Published public var alert: RootAlert? = nil
    
    public init() {}
}

// MARK: - Alert

public extension Router {
    func presentAlert(_ alert: RootAlert) {
        self.alert = alert
    }

    func dismissAlert() {
        alert = nil
    }
}

// MARK: - HUD

public extension Router {
    func presentHud(_ text: String) {
        hudText = text
        isShowHud = true
    }
}
// MARK: - Route and Tabs

public extension Router {
    func changeTab(_ tab: RootTab) {
        self.tab = tab
    }

    func move(_ screen: Screen) {
        switch tab {
        case .main:
            mainPath.append(screen)
        case .secondary:
            secondaryPath.append(screen)
        case .tertiary:
            tertiaryPath.append(screen)
        case .quaternary:
            quaternaryPath.append(screen)
        case .settings:
            settingsPath.append(screen)
        }
    }

    
    func backToRoot() {
        switch tab {
        case .main:
            mainPath.removeLast(mainPath.count)
        case .secondary:
            secondaryPath.removeLast(secondaryPath.count)
        case .tertiary:
            tertiaryPath.removeLast(tertiaryPath.count)
        case .quaternary:
            quaternaryPath.removeLast(quaternaryPath.count)
        case .settings:
            settingsPath.removeLast(settingsPath.count)
        }
    }

    func back(_ count: Int = 1) {
        switch tab {
        case .main:
            let pathCount = mainPath.count - count
            if pathCount > -1 {
                mainPath.removeLast(count)
            }
        case .secondary:
            let pathCount = secondaryPath.count - count
            if pathCount > -1 {
                secondaryPath.removeLast(count)
            }
        case .tertiary:
            let pathCount = tertiaryPath.count - count
            if pathCount > -1 {
                tertiaryPath.removeLast(count)
            }
        case .quaternary:
            let pathCount = quaternaryPath.count - count
            if pathCount > -1 {
                quaternaryPath.removeLast(count)
            }
        case .settings:
            let pathCount = settingsPath.count - count
            if pathCount > -1 {
                settingsPath.removeLast(count)
            }
        }
    }
}

// MARK: - Sheets

public extension Router {
    func present(_ sheet: Screen, fullScreen: Bool = false) {
        if fullScreen {
            if fullScreenCover != nil {
                fullScreenCover = nil
            }
            fullScreenCover = sheet
        } else {
            restSheet()
            self.sheet = sheet
        }
    }

    func present(_ sheet: Screen, detents: Set<PresentationDetent> = [.large], indicator: Visibility = .hidden, dismissDisabled: Bool = false) {
        restSheet()
        sheetDetents = detents
        dragIndicator = indicator
        self.dismissDisabled = dismissDisabled
        self.sheet = sheet
    }

    func dismiss() {
        sheet = nil
        fullScreenCover = nil
    }

    func dismissSheet() {
        sheet = nil
    }

    func dismissFullScreenCover() {
        fullScreenCover = nil
    }

    func dismissDisabled(_ isDismissDisabled: Bool = true) {
        dismissDisabled = isDismissDisabled
    }

    private func restSheet() {
        if sheet != nil {
            sheet = nil
        }
        if fullScreenCover != nil {
            fullScreenCover = nil
        }
        if dragIndicator != .hidden {
            dragIndicator = .hidden
        }
        if dismissDisabled {
            dismissDisabled = false
        }
        if sheetDetents.isEmpty == false {
            sheetDetents = []
        }
    }
}

public extension Router {
    func handle(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return
        }
        var pathComponents = components.path.components(separatedBy: "/")
        pathComponents.removeFirst()

        switch host {
        case "settings":
            changeTab(.settings)
            backToRoot()
        case "premium":
            present(.premium)
        default:
            break
        }
    }
}

extension Screen: Hashable, Equatable {
    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
