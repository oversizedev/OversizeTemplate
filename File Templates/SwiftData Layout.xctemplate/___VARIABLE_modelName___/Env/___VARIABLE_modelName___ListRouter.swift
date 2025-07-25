// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import NavigatorUI
import SwiftUI

public enum ___VARIABLE_modelName___Destinations {
    case ___VARIABLE_modelPluralVariableName___List
    case ___VARIABLE_modelVariableName___Details(id: UUID)
    case ___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
    case ___VARIABLE_modelVariableName___create
    case ___VARIABLE_modelVariableName___Edit(id: UUID)
    case ___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___)
}

extension ___VARIABLE_modelName___Destinations: NavigationDestination {
    public var body: some View {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            ___VARIABLE_modelName___ListScreen.build()
        case let .___VARIABLE_modelVariableName___Details(id):
            ___VARIABLE_modelName___DetailScreen.build(id: id)
        case let .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___DetailScreen.build(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        case .___VARIABLE_modelVariableName___create:
            ___VARIABLE_modelName___EditScreen.build()
        case let .___VARIABLE_modelVariableName___Edit(id: id):
            ___VARIABLE_modelName___EditScreen.buildEdit(id: id)
        case let .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___):
            ___VARIABLE_modelName___EditScreen.buildEdit(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___)
        }
    }

    public var method: NavigationMethod {
        switch self {
        case .___VARIABLE_modelVariableName___create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___:
            .managedSheet
        default:
            .push
        }
    }
    
    // MARK: - Enhanced Navigation Properties
    
    /// Navigation title for the destination
    public var navigationTitle: String {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            "___VARIABLE_modelName___ List"
        case .___VARIABLE_modelVariableName___Details, .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___:
            "___VARIABLE_modelName___ Details"
        case .___VARIABLE_modelVariableName___create:
            "Create ___VARIABLE_modelName___"
        case .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___:
            "Edit ___VARIABLE_modelName___"
        }
    }
    
    /// Whether the destination supports dismissal
    public var isDismissible: Bool {
        switch self {
        case .___VARIABLE_modelVariableName___create, .___VARIABLE_modelVariableName___Edit, .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___:
            true
        default:
            false
        }
    }
    
    /// Accessibility identifier for the destination
    public var accessibilityIdentifier: String {
        switch self {
        case .___VARIABLE_modelPluralVariableName___List:
            "___VARIABLE_modelName___ListScreen"
        case .___VARIABLE_modelVariableName___Details:
            "___VARIABLE_modelName___DetailScreen"
        case .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___:
            "___VARIABLE_modelName___DetailScreen"
        case .___VARIABLE_modelVariableName___create:
            "___VARIABLE_modelName___CreateScreen"
        case .___VARIABLE_modelVariableName___Edit:
            "___VARIABLE_modelName___EditScreen"
        case .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___:
            "___VARIABLE_modelName___EditScreen"
        }
    }
}

// MARK: - Router with Callback System

public final class ___VARIABLE_modelName___Router: ObservableObject {
    @Published public var navigationPath = NavigationPath()
    @Published public var presentedDestination: ___VARIABLE_modelName___Destinations?
    
    // Callback system for inter-screen communication
    public var onItemCreated: ((___VARIABLE_modelName___) -> Void)?
    public var onItemUpdated: ((___VARIABLE_modelName___) -> Void)?
    public var onItemDeleted: ((UUID) -> Void)?
    public var onNavigationComplete: ((___VARIABLE_modelName___Destinations) -> Void)?
    
    public init() {}
    
    // MARK: - Navigation Methods
    
    public func navigate(to destination: ___VARIABLE_modelName___Destinations) {
        switch destination.method {
        case .push:
            navigationPath.append(destination)
        case .sheet, .managedSheet, .fullScreenCover:
            presentedDestination = destination
        }
        onNavigationComplete?(destination)
    }
    
    public func dismiss() {
        if presentedDestination != nil {
            presentedDestination = nil
        } else if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    public func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
        presentedDestination = nil
    }
    
    public func replace(with destination: ___VARIABLE_modelName___Destinations) {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
        navigate(to: destination)
    }
    
    // MARK: - Convenience Methods
    
    public func showList() {
        navigate(to: .___VARIABLE_modelPluralVariableName___List)
    }
    
    public func showDetails(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        navigate(to: .___VARIABLE_modelVariableName___Details___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
    }
    
    public func showDetails(id: UUID) {
        navigate(to: .___VARIABLE_modelVariableName___Details(id: id))
    }
    
    public func showCreate() {
        navigate(to: .___VARIABLE_modelVariableName___create)
    }
    
    public func showEdit(for ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        navigate(to: .___VARIABLE_modelVariableName___Edit___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
    }
    
    public func showEdit(id: UUID) {
        navigate(to: .___VARIABLE_modelVariableName___Edit(id: id))
    }
    
    // MARK: - Callback Methods
    
    public func itemCreated(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        onItemCreated?(___VARIABLE_modelVariableName___)
        dismiss()
    }
    
    public func itemUpdated(_ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        onItemUpdated?(___VARIABLE_modelVariableName___)
        dismiss()
    }
    
    public func itemDeleted(id: UUID) {
        onItemDeleted?(id)
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}

public struct ___VARIABLE_modelName___RootView: View {
    public init() {}

    public var body: some View {
        ManagedNavigationStack {
            ___VARIABLE_modelName___ListScreen.build()
                .navigationDestinationAutoReceive(___VARIABLE_modelName___Destinations.self)
        }
        .systemServices()
    }
}
