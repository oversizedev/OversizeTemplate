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

#Preview {
    ___FILEBASENAMEASIDENTIFIER___()
}
