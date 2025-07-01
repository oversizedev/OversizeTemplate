// ___FILEHEADER___

import OversizeUI
import SwiftUI

public struct ___FILEBASENAMEASIDENTIFIER___: View {

    @State var viewState: ___VARIABLE_productName___ViewState
    let reducer: ___VARIABLE_productName___Reducer

    // Initial
    public init(viewState: ___VARIABLE_productName___ViewState, reducer: ___VARIABLE_productName___Reducer) {
        self.viewState = viewState
        self.reducer = reducer
    }
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

public extension ___FILEBASENAMEASIDENTIFIER___ {
    static func build() -> some View {
        let viewState = ___VARIABLE_productName___ViewState()
        let viewModel = ___VARIABLE_productName___ViewModel(state: viewState)
        let reducer = ___VARIABLE_productName___Reducer(viewModel: viewModel)
        return ___FILEBASENAMEASIDENTIFIER___(viewState: viewState, reducer: reducer)
    }
}

#Preview {
    ___FILEBASENAMEASIDENTIFIER___.build()
}
