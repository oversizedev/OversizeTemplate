//
// Copyright © ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___.swift, created on ___DATE___
//

import OversizeUI
import SwiftUI

extension ___VARIABLE_productName:identifier___ViewModel {
    func present(_ sheet: Screen, detents: Set<PresentationDetent> = [], indicator: Visibility = .hidden, dismissDisabled: Bool = false) {
        restSheet()
        sheetDetents = detents
        dragIndicator = indicator
        self.dismissDisabled = dismissDisabled
        self.sheet = sheet
    }
    
    func dismiss() {
        sheet = nil
    }
    
    func dismissDisabled(_ isDismissDisabled: Bool = true) {
        dismissDisabled = isDismissDisabled
    }
    
    private func restSheet() {
        if sheet != nil {
            sheet = nil
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
