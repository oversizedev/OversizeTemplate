// ___FILEHEADER___

import SwiftUI

// MARK: - ViewState Protocol

public protocol ViewStateProtocol: ObservableObject {
    associatedtype Input
    func update(_ input: Input)
}

// MARK: - ViewState Input

public enum ___VARIABLE_productName___ViewStateInput {
    case loading(Bool)
    case error(String?)
}

// MARK: - ViewState

@MainActor
public final class ___FILEBASENAMEASIDENTIFIER___: ViewStateProtocol, ObservableObject {
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String?
    
    /// Initialization
    public init() {}
    
    /// Update method conforming to ViewStateProtocol
    public func update(_ input: ___VARIABLE_productName___ViewStateInput) {
        switch input {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .error(let message):
            self.errorMessage = message
        }
    }
}
