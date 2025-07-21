// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___NotFoundView: View {
    @Environment(\.screenSize) var screenSize

    let searchTerm: String

    var body: some View {
        ContentView(
            image: Illustration.Objects.search,
            title: "Nothing found",
            subtitle: "No ___VARIABLE_modelPluralVariableName___ match '\(searchTerm)'\nTry adjusting your search"
        )
        .padding(.top, .xLarge)
        .multilineTextAlignment(.center)
        .padding(.horizontal, .medium)
        .paddingContent()
        .padding(.top, screenSize.height < 670 ? -70 : 0)
    }
}

#Preview {
    ___VARIABLE_modelName___NotFoundView(searchTerm: "example search")
}