// ___FILEHEADER___

import Foundation
import OversizeCore

public final class MealProductEditReducer: Sendable {
    private let viewModel: MealProductEditViewModel

    public init(viewModel: MealProductEditViewModel) {
        self.viewModel = viewModel
    }

    func callAsFunction(_ event: MealProductEditViewModel.InputEvent, function _: String = #function, file _: String = #file) {
        Task {
            logUI(String(describing: event))
            await viewModel.handleEvent(event)
        }
    }
}
