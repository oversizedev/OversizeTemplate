// ___FILEHEADER___

import SwiftUI

extension ___FILEBASENAMEASIDENTIFIER___ {
    enum InputEvent {
        case onAppear
    }
}

public actor ___FILEBASENAMEASIDENTIFIER___ {
    /// ViewState
    public var state: ___VARIABLE_productName___ViewState

    /// Initialization
    public init(state: ___VARIABLE_productName___ViewState) {
        self.state = state
    }

    func handleEvent(_ event: InputEvent) async {
        switch event {
        case .onAppear:
            await onAppear()
        }
    }
}

// MARK: - User Actions

public extension ___FILEBASENAMEASIDENTIFIER___ {
    func onAppear() async { }
}
