// ___FILEHEADER___

import Foundation
import OversizeCore

public final class ___VARIABLE_modelName___DetailReducer: Sendable {
    private let viewModel: ___VARIABLE_modelName___DetailViewModel

    public init(viewModel: ___VARIABLE_modelName___DetailViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ action: ___VARIABLE_modelName___DetailViewModel.Action, function: String = #function, file: String = #file) {
        Task {
            logUI(String(describing: action))
            await viewModel.handleAction(action)
        }
    }
    
    // MARK: - Async Send Method for Modern Usage
    
    func send(_ action: ___VARIABLE_modelName___DetailViewModel.Action) async {
        logUI(String(describing: action))
        await viewModel.handleAction(action)
    }
}
