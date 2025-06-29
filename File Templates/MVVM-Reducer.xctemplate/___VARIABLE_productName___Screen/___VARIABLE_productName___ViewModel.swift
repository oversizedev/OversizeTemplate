// ___FILEHEADER___

import SwiftUI

// MARK: - ViewModel Protocol

public protocol ViewModelProtocol: Sendable {
    associatedtype Input
    associatedtype Output
    associatedtype Action
    associatedtype ViewState: ViewStateProtocol
    associatedtype Router: RouterProtocol
    
    var viewState: ViewState { get }
    var router: Router { get }
    
    func handle(_ action: Action) async
}

// MARK: - ViewModel Actions

public enum ___VARIABLE_productName___Action {
    case onAppear
    case refresh
}

// MARK: - ViewModel Input/Output

public enum ___VARIABLE_productName___Input {
    case viewLoaded
}

public enum ___VARIABLE_productName___Output {
    case dataLoaded
    case error(String)
}

// MARK: - ViewModel

public actor ___FILEBASENAMEASIDENTIFIER___: ViewModelProtocol {
    
    public let viewState: ___VARIABLE_productName___ViewState
    public let router: ___VARIABLE_productName___Router
    
    /// Initialization
    public init(viewState: ___VARIABLE_productName___ViewState, router: ___VARIABLE_productName___Router) {
        self.viewState = viewState
        self.router = router
    }
    
    /// Handle actions conforming to ViewModelProtocol
    public func handle(_ action: ___VARIABLE_productName___Action) async {
        switch action {
        case .onAppear:
            await onAppear()
        case .refresh:
            await refresh()
        }
    }
}

// MARK: - Private Methods

private extension ___FILEBASENAMEASIDENTIFIER___ {
    
    func onAppear() async {
        await viewState.update(.loading(true))
        // Add your logic here
        await viewState.update(.loading(false))
    }
    
    func refresh() async {
        await viewState.update(.loading(true))
        // Add your refresh logic here
        await viewState.update(.loading(false))
    }
}
