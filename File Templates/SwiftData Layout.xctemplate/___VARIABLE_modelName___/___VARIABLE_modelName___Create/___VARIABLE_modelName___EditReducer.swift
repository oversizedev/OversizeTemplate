// ___FILEHEADER___

import Foundation

public final class ___VARIABLE_modelName___EditReducer: Sendable {
    private let viewModel: ___VARIABLE_modelName___EditViewModel

    public init(viewModel: ___VARIABLE_modelName___EditViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: ___VARIABLE_modelName___EditViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            await viewModel.handleEvent(event)
        }
    }
}