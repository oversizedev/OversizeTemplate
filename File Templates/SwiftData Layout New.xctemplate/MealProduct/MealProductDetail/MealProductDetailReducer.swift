// ___FILEHEADER___

import Foundation
import OversizeCore

public final class MealProductDetailReducer: Sendable {
    private let viewModel: MealProductDetailViewModel

    public init(viewModel: MealProductDetailViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: MealProductDetailViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            logUI(String(describing: event))
            await viewModel.handleEvent(event)
        }
    }
}
