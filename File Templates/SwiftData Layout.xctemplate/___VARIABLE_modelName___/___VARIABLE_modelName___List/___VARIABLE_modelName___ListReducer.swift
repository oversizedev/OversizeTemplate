// ___FILEHEADER___

import Foundation
import OversizeCore

public final class ___VARIABLE_modelName___ListReducer: Reducer<___VARIABLE_modelName___ListViewModel> {
    public override init(viewModel: ___VARIABLE_modelName___ListViewModel) {
        super.init(viewModel: viewModel)
    }

    func callAsFunction(_ action: ___VARIABLE_modelName___ListViewModel.Action, function: String = #function, file: String = #file) {
        Task {
            logUI(String(describing: action))
            await viewModel.handleAction(action)
        }
    }
}
