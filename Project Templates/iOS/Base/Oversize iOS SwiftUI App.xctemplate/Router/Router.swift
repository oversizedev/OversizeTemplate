//___FILEHEADER___

import SwiftUI

@MainActor
public final class Router: ObservableObject {
    
    // Path
    @Published var path = NavigationPath()
    
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

// MARK: - Route

public extension Router {
    
    func move(_ screen: Screen) {
        path.append(screen)
    }

    func backToRoot() {
        path.removeLast(path.count)
    }

    func back(_ count: Int = 1) {
        let pathCount = path.count - count
        if pathCount > -1 {
            path.removeLast(count)
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
