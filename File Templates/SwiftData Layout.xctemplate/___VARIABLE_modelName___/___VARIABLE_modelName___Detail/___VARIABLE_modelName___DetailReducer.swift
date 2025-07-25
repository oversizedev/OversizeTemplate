// ___FILEHEADER___

import Foundation
import OversizeCore

public final class ___VARIABLE_modelName___DetailReducer: Reducer<___VARIABLE_modelName___DetailViewModel> {
    public override init(viewModel: ___VARIABLE_modelName___DetailViewModel) {
        super.init(viewModel: viewModel)
    }

    func callAsFunction(_ action: ___VARIABLE_modelName___DetailViewModel.Action, function: String = #function, file: String = #file) {
        Task {
            logUI(String(describing: action))
            await viewModel.handleAction(action)
        }
    }
}
