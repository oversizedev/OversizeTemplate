// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___DetailPlaceholder: View {
    init() {}

    var body: some View {
        Section("Information") {
            ForEach(0 ... 2, id: \.self) { _ in
                ListRow("Title", subtitle: "Subtitle")
            }
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    List {
        ___VARIABLE_modelName___DetailPlaceholder()
    }
}
