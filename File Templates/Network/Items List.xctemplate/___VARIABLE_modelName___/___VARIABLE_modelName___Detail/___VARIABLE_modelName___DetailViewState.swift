// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
import FactoryKit
import ObservableDefaults
import Observation
import OversizeArchitecture
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeNavigation
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___DetailViewState: ViewStateProtocol, Sendable {
    public typealias Module = ___VARIABLE_modelName___Detail

    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var isDismissed: Bool = false

    public let ___VARIABLE_modelVariableName___Id: String

    public required init(input: Module.Input?) {
        if let ___VARIABLE_modelVariableName___ = input?.___VARIABLE_modelVariableName___ {
            ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id.uuidString
            ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
        } else {
            ___VARIABLE_modelVariableName___Id = input?.___VARIABLE_modelVariableName___Id ?? ""
        }
    }
}
