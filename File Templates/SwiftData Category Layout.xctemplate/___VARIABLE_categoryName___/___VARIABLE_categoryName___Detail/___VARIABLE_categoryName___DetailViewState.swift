// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_categoryName___DetailViewState: ViewStateProtocol {
    // User Interface
    public var ___VARIABLE_categoryVariableName___State: LoadingState<___VARIABLE_categoryName___> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    // Routing
    public var destination: ___VARIABLE_categoryName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Static
    public let ___VARIABLE_categoryVariableName___Id: UUID

    // Initialization
    public init(___VARIABLE_categoryVariableName___Id: UUID) {
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id
    }

    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
        ___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
    }
}

// MARK: - User Actions

public extension ___VARIABLE_categoryName___DetailViewState {}