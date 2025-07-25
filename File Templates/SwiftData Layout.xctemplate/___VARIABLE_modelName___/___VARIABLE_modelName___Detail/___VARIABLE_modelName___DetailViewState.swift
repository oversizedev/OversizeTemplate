// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import ___VARIABLE_environmentPackage___
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
public final class ___VARIABLE_modelName___DetailViewState: ViewStateProtocol, Sendable {
    // User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingState<___VARIABLE_modelName___> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero


    // Routing
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var isDismissed: Bool = false

    // Static
    public let ___VARIABLE_modelVariableName___Id: UUID
    
    // Computed properties
    public var ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___? {
        ___VARIABLE_modelVariableName___State.result
    }

    // Initialization
    public init(___VARIABLE_modelVariableName___Id: UUID) {
        self.___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___Id
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
        ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewState {
    func update(_ handler: @Sendable @MainActor (___VARIABLE_modelName___DetailViewState) -> Void) async {
        await MainActor.run { handler(self) }
    }
}
