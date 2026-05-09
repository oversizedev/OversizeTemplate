// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___DetailViewState: ViewStateProtocol {
    // User Interface
    public var state: LoadingState<StateModel> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    // Routing
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    /// Static
    public let ___VARIABLE_categoryVariableName___Id: UUID

    /// Initialization
    public init(input: ___VARIABLE_categoryName___Detail.Input?) {
        guard let input else {
            ___VARIABLE_categoryVariableName___Id = UUID()
            return
        }

        switch input.source {
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
        case let .id(id):
            ___VARIABLE_categoryVariableName___Id = id
        }
    }
}

// MARK: - State Model

public extension ___VARIABLE_categoryName___DetailViewState {
    struct StateModel: Emptyable, Sendable {
        public var ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
        public var ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
        public var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]

        public var isEmpty: Bool {
            ___VARIABLE_modelPluralVariableName___.isEmpty
        }
    }
}
