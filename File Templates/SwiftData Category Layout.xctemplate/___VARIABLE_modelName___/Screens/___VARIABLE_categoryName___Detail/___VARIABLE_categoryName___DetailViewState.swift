// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___DetailViewState: ViewStateProtocol {
    // User Interface
    public var ___VARIABLE_categoryVariableName___State: LoadingState<___VARIABLE_categoryName___> = .idle
    public var ___VARIABLE_modelPluralVariableName___State: EmptyableLoadingState<[___VARIABLE_modelName___]> = .idle
    public var ___VARIABLE_categoryPluralVariableName___State: LoadingState<[___VARIABLE_categoryName___]> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    // Routing
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var hud: OversizeNavigation.HUD?
    public var isDismissed: Bool = false

    // Static
    public let ___VARIABLE_categoryVariableName___Id: UUID

    // Initialization
    public init(input: ___VARIABLE_categoryName___Detail.Input?) {
        guard let input else {
            ___VARIABLE_categoryVariableName___Id = UUID()
            return
        }

        switch input.source {
        case let .___VARIABLE_categoryVariableName___(___VARIABLE_categoryVariableName___):
            ___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
            ___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
        case let .id(id):
            ___VARIABLE_categoryVariableName___Id = id
            ___VARIABLE_categoryVariableName___State = .loading
        }
    }
}