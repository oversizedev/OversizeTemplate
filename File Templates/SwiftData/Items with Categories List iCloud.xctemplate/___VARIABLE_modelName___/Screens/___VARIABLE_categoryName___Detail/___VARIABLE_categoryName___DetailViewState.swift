// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Env
import Models
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeNavigation
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___DetailViewState: ViewStateProtocol {
    // MARK: - User Interface

    public var state: LoadingState<StateModel> = .idle

    // MARK: - Routing

    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // MARK: - Constants

    public let ___VARIABLE_categoryVariableName___Id: UUID

    // MARK: - Initialization

    public init(input: ___VARIABLE_categoryName___Detail.Input?) {
        ___VARIABLE_categoryVariableName___Id = input?.___VARIABLE_categoryVariableName___Id ?? UUID()
    }
}

// MARK: - State Model

public extension ___VARIABLE_categoryName___DetailViewState {
    struct StateModel: Equatable, Sendable {
        public var ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
        public var ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
        public var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    }
}
