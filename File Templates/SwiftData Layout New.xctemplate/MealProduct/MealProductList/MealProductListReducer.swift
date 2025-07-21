// ___FILEHEADER___

import Foundation
import OversizeCore

public final class MealProductListReducer: Sendable {
    private let viewModel: MealProductListViewModel

    public init(viewModel: MealProductListViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: MealProductListViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            logUI(String(describing: event))
            await viewModel.handleEvent(event)
        }
    }
}
