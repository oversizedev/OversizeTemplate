// ___FILEHEADER___

import Foundation

// MARK: - Generic Reducer

public final class Reducer<Action>: Sendable {
    private let handler: @Sendable (Action) async -> Void
    
    public init(handler: @escaping @Sendable (Action) async -> Void) {
        self.handler = handler
    }
    
    public func callAsFunction(_ action: Action) {
        Task {
            await handler(action)
        }
    }
}

// MARK: - Specific Reducer

public final class ___FILEBASENAMEASIDENTIFIER___: Sendable {
    private let viewModel: ___VARIABLE_productName___ViewModel
    
    public init(viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
    }
    
    public func callAsFunction(_ action: ___VARIABLE_productName___Action) {
        Task {
            await viewModel.handle(action)
        }
    }
}
