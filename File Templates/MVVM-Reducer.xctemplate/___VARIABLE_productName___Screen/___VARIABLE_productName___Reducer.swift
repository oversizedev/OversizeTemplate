// ___FILEHEADER___

import Foundation

public final class ___FILEBASENAMEASIDENTIFIER___: Sendable {
    private let viewModel: ___VARIABLE_productName___ViewModel

    public init(viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: ___VARIABLE_productName___ViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            await viewModel.handleEvent(event)
        }
    }
}
