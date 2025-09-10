// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Foundation
import OversizeCore
import OversizeUI
import SwiftUI

@Observable
public final class ___VARIABLE_categoryName___DetailViewState {
    public var ___VARIABLE_categoryVariableName___State: LoadingState<___VARIABLE_categoryName___> = .idle
    public var hud: HUDState = .none
    public var alert: AlertState = .none
    public var destination: ___VARIABLE_modelName___Destinations?
    public let ___VARIABLE_categoryVariableName___Id: UUID

    public init(___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___) {
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___.id
        self.___VARIABLE_categoryVariableName___State = .result(___VARIABLE_categoryVariableName___)
    }

    public init(___VARIABLE_categoryVariableName___Id: UUID) {
        self.___VARIABLE_categoryVariableName___Id = ___VARIABLE_categoryVariableName___Id
    }
}