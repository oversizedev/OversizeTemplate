// ___FILEHEADER___

import UIKit
import SwiftUI

// MARK: - Router Protocol

@MainActor
public protocol RouterProtocol {
    var parentViewController: UIViewController? { get set }
}

// MARK: - Router

@MainActor
public final class ___FILEBASENAMEASIDENTIFIER___: RouterProtocol, ObservableObject {
    
    public weak var parentViewController: UIViewController?
    
    /// Initialization
    public init(parentViewController: UIViewController? = nil) {
        self.parentViewController = parentViewController
    }
}

// MARK: - Navigation Methods

@MainActor
public extension ___FILEBASENAMEASIDENTIFIER___ {
    
    func presentSheet<Content: View>(@ViewBuilder content: () -> Content) {
        let hostingController = UIHostingController(rootView: content())
        parentViewController?.present(hostingController, animated: true)
    }
    
    func pushViewController(_ viewController: UIViewController) {
        if let navigationController = parentViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else if let navigationController = parentViewController?.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func dismissModal() {
        parentViewController?.dismiss(animated: true)
    }
    
    func popViewController() {
        if let navigationController = parentViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        } else if let navigationController = parentViewController?.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}