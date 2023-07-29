//___FILEHEADER___

import SwiftUI

@MainActor
final class Router: ObservableObject {
    
    // Route and Tabs
    @Published var mainPath: [Screen] = []
    @Published var secondaryPath: [Screen] = []
    @Published var tertiaryPath: [Screen] = []
    @Published var quaternaryPath: [Screen] = []
    @Published var settingsPath: [Screen] = []
    @Published var tab: RootTab = .main

    // Sheets
    @Published var sheet: Screen?
    @Published var fullScreenCover: Screen?
    @Published private(set) var sheetDetents: Set<PresentationDetent> = []
    @Published private(set) var dragIndicator: Visibility = .hidden
    @Published private(set) var dismissDisabled: Bool = false

    // Hud
    @Published var isShowHud: Bool = false
    @Published var hudText: String = ""

    // Alert
    @Published var alert: RootAlert? = nil
}

// MARK: - Alert

extension Router {
    func presentAlert(_ alert: RootAlert) {
        self.alert = alert
    }

    func dismissAlert() {
        alert = nil
    }
}

// MARK: - HUD

extension Router {
    func presentHud(_ text: String) {
        hudText = text
        isShowHud = true
    }
}

// MARK: - Route and Tabs

extension Router {
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
            mainPath.removeAll()
        case .secondary:
            secondaryPath.removeAll()
        case .tertiary:
            tertiaryPath.removeAll()
        case .quaternary:
            quaternaryPath.removeAll()
        case .settings:
            settingsPath.removeAll()
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

extension Router {
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

extension Router {
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
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
