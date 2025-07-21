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
public final class ___VARIABLE_modelName___DetailViewState: Sendable {
    // User Interface
    public var ___VARIABLE_modelVariableName___State: LoadingViewState<___VARIABLE_modelName___> = .idle
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero
    public var isShowingDeleteConfirmation: Bool = false
    public var isProcessing: Bool = false

    // Routing
    public var destination: ___VARIABLE_modelName___Destinations?
    public var alert: AppAlert?
    public var isDismissed: Bool = false

    // Static
    public let ___VARIABLE_modelVariableName___Id: UUID

    // Computed Properties
    public var title: String {
        ___VARIABLE_modelVariableName___State.result?.name ?? "___VARIABLE_modelName___ Detail"
    }

    public var canDelete: Bool {
        !isProcessing && ___VARIABLE_modelVariableName___State.result != nil
    }

    public var canEdit: Bool {
        !isProcessing && ___VARIABLE_modelVariableName___State.result != nil
    }

    public var canToggleActions: Bool {
        !isProcessing && ___VARIABLE_modelVariableName___State.result != nil
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

    func setProcessing(_ isProcessing: Bool) {
        self.isProcessing = isProcessing
    }

    func showDeleteConfirmation() {
        guard canDelete else { return }
        isShowingDeleteConfirmation = true
    }

    func hideDeleteConfirmation() {
        isShowingDeleteConfirmation = false
    }

    func dismissView() {
        isDismissed = true
    }

    func showError(_ error: AppError) {
        alert = .error(error)
    }

    func update___VARIABLE_modelName___(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___State = .result(___VARIABLE_modelVariableName___)
    }
}
