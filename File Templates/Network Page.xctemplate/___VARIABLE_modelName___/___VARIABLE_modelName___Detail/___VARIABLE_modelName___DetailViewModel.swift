// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeKit
import OversizeModels
import OversizeUI
import SwiftUI

@MainActor
@Observable
public final class ___VARIABLE_modelName___DetailViewModel {
    public struct StateModel {
        public let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    }

    /// User Interface
    public var state: LoadingViewState<StateModel> = .idle

    private let ___VARIABLE_modelVariableName___Id: String
    public var headerVisibleRatio: CGFloat = .zero
    public var offset: CGPoint = .zero

    /// Initialization
    public init(id: String) {
        ___VARIABLE_modelVariableName___Id = id
    }

    public init(___VARIABLE_modelVariableName___: ___VARIABLE_modelName___) {
        ___VARIABLE_modelVariableName___Id = ___VARIABLE_modelVariableName___.id
        state = .result(.init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
    }
}

// MARK: - User Actions

public extension ___VARIABLE_modelName___DetailViewModel {
    func onAppear() async {
        if state.result == nil {
            await fetchData()
        }
    }

    func onRefresh() async {
        await fetchData()
    }

    func onScroll(_ offset: CGPoint, _ headerVisibleRatio: CGFloat) {
        DispatchQueue.main.async {
            self.offset = offset
            self.headerVisibleRatio = headerVisibleRatio
        }
    }
}

// MARK: - Data Fetching

public extension ___VARIABLE_modelName___DetailViewModel {
    func fetchData() async {
        let result = await fetch___VARIABLE_modelName___()
        switch result {
        case let .success(___VARIABLE_modelVariableName___):
            state = .result(.init(___VARIABLE_modelVariableName___: ___VARIABLE_modelVariableName___))
        case let .failure(error):
            state = .error(error)
        }
    }

    func fetch___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        .failure(AppError.network(type: .unknown))
    }

    func delete___VARIABLE_modelName___() async -> Result<___VARIABLE_modelName___, AppError> {
        .failure(AppError.network(type: .unknown))
    }
}
