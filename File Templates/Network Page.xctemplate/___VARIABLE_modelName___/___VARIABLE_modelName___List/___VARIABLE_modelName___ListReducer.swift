// ___FILEHEADER___

import Foundation
import OversizeCore

public final class ___VARIABLE_modelName___ListReducer: Sendable {

    private let viewModel: ___VARIABLE_modelName___ListViewModel
    
    public init(viewModel: ___VARIABLE_modelName___ListViewModel) {
        self.viewModel = viewModel
    }
    
    func callAsFunction(_ event: ___VARIABLE_modelName___ListViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            logUI(event)
            await viewModel.handleEvent(event)
        }
    }
}
