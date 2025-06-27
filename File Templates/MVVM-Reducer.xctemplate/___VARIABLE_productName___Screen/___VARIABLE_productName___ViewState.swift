// ___FILEHEADER___

import SwiftUI

@MainActor
@Observable
public final class ___FILEBASENAMEASIDENTIFIER___: Sendable {

    /// Initialization
    public init() {}
}

// MARK: - User Actions

public extension ___FILEBASENAMEASIDENTIFIER___ {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_productName___ViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
}
