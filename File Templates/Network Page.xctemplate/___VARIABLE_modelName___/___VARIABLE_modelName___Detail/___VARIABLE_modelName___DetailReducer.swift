// ___FILEHEADER___

import Foundation
import OversizeCore

public final class ___VARIABLE_modelName___DetailReducer: Sendable {
    private let viewModel:___VARIABLE_modelName___DetailViewModel

    public init(viewModel: ___VARIABLE_modelName___DetailViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: ___VARIABLE_modelName___DetailViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            // logUI(event)
            await viewModel.handleEvent(event)
        }
    }
}
