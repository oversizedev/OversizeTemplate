//___FILEHEADER___

import Foundation

public final class Reducer<ViewModel>: Sendable where ViewModel: ViewModelProtocol {
    private let viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: ViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            await viewModel.handleAction(event)
        }
    }
}