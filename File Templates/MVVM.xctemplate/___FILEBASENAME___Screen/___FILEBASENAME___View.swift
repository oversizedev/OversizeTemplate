// ___FILEHEADER___

import OversizeCraft
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @StateObject var viewModel: ___FILEBASENAMEASIDENTIFIER___Model

    init() {
        _viewModel = StateObject(wrappedValue: ___FILEBASENAMEASIDENTIFIER___Model())
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ___FILEBASENAMEASIDENTIFIER____ViewPreviews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___()
    }
}
