// ___FILEHEADER___

import UIKit
import SwiftUI

// MARK: - Module Protocol

public protocol ModuleProtocol {
    static func build() -> UIViewController
}

// MARK: - Module

public final class ___FILEBASENAMEASIDENTIFIER___: ModuleProtocol {
    
    /// Build method conforming to ModuleProtocol
    public static func build() -> UIViewController {
        // Create ViewState
        let viewState = ___VARIABLE_productName___ViewState()
        
        // Create Router
        let router = ___VARIABLE_productName___Router()
        
        // Create ViewModel
        let viewModel = ___VARIABLE_productName___ViewModel(viewState: viewState, router: router)
        
        // Create Reducer
        let reducer = ___VARIABLE_productName___Reducer(viewModel: viewModel)
        
        // Create View
        let view = ___VARIABLE_productName___Screen(viewState: viewState, reducer: reducer)
        
        // Create UIViewController
        let hostingController = UIHostingController(rootView: view)
        
        // Set router's parent view controller
        router.parentViewController = hostingController
        
        return hostingController
    }
}

// MARK: - SwiftUI Build Method

public extension ___FILEBASENAMEASIDENTIFIER___ {
    /// Build SwiftUI View directly
    static func buildView() -> ___VARIABLE_productName___Screen {
        let viewState = ___VARIABLE_productName___ViewState()
        let router = ___VARIABLE_productName___Router()
        let viewModel = ___VARIABLE_productName___ViewModel(viewState: viewState, router: router)
        let reducer = ___VARIABLE_productName___Reducer(viewModel: viewModel)
        
        return ___VARIABLE_productName___Screen(viewState: viewState, reducer: reducer)
    }
}