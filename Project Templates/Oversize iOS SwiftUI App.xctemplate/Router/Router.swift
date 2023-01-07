//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeComponents
import OversizeKit
import SwiftUI

class Router: ObservableObject {
    @Published var path: [Route] = []
    @Published var sheet: Sheet?
    @Published var fullScreenCover: Sheet?

    func move(_ screen: Route) {
        path.append(screen)
    }

    func backToRoot() {
        path.removeAll()
    }

    func back(_ count: Int = 1) {
        let pathCount = path.count - count
        if pathCount > -1 {
            path.removeLast(count)
        }
    }

    func present(_ sheet: Sheet, fullScreen: Bool = false) {
        if fullScreen {
            self.fullScreenCover = sheet
        } else {
            self.sheet = sheet
        }
    }

    func close() {
        sheet = nil
        fullScreenCover = nil
    }
}

extension Route: Hashable, Equatable {
    static func == (lhs: Route, rhs: Route) -> Bool {
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

extension Sheet: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
}
