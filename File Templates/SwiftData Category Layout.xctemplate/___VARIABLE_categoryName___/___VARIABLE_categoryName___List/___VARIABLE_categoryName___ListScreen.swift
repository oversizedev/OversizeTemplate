// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___ListScreen: View {
    @StateObject private var viewModel: ___VARIABLE_categoryName___ListViewModel
    private let reducer: Reducer<___VARIABLE_categoryName___ListViewModel>

    public init(viewModel: ___VARIABLE_categoryName___ListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        reducer = Reducer(viewModel: viewModel)
    }

    public var body: some View {
        NavigationLayoutView("___VARIABLE_categoryPluralVariableName___") {
            switch viewModel.state.___VARIABLE_categoryPluralVariableName___State {
            case .idle:
                ProgressView()
                    .onAppear { reducer(.onAppear) }
            case .loading:
                ProgressView()
            case let .result(___VARIABLE_categoryPluralVariableName___):
                content(___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___)
            case let .error(error):
                ErrorView(error.localizedDescription)
                    .onAppear { reducer(.onAppear) }
            }
        }
        .navigationDestinationAutoReceive(___VARIABLE_categoryName___Destinations.self)
        .alert(using: $viewModel.state.alert)
        .hud(using: $viewModel.state.hud)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add", systemImage: "plus") {
                    reducer(.onTapCreate___VARIABLE_categoryName___)
                }
            }
        }
    }

    private func content(___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]) -> some View {
        Group {
            if ___VARIABLE_categoryPluralVariableName___.isEmpty {
                ___VARIABLE_categoryName___PlaceholderView(filterType: viewModel.state.filterType)
            } else {
                ___VARIABLE_categoryName___ListContentView(
                    ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___,
                    onTapCategory: { ___VARIABLE_categoryVariableName___ in
                        reducer(.onTapDetail___VARIABLE_categoryName___(___VARIABLE_categoryVariableName___))
                    }
                )
            }
        }
    }
}

// MARK: - Builders

public extension ___VARIABLE_categoryName___ListScreen {
    @MainActor
    static func build() -> some View {
        let state = ___VARIABLE_categoryName___ListViewState()
        let viewModel = ___VARIABLE_categoryName___ListViewModel(state: state)
        return ___VARIABLE_categoryName___ListScreen(viewModel: viewModel)
    }

    @MainActor
    static func buildArchive() -> some View {
        let state = ___VARIABLE_categoryName___ListViewState(filterType: .archived)
        let viewModel = ___VARIABLE_categoryName___ListViewModel(state: state)
        return ___VARIABLE_categoryName___ListScreen(viewModel: viewModel)
    }

    @MainActor
    static func buildFavorites() -> some View {
        let state = ___VARIABLE_categoryName___ListViewState(filterType: .favorites)
        let viewModel = ___VARIABLE_categoryName___ListViewModel(state: state)
        return ___VARIABLE_categoryName___ListScreen(viewModel: viewModel)
    }
}