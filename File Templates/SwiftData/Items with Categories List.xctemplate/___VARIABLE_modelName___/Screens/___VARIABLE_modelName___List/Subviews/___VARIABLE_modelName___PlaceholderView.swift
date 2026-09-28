// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___PlaceholderView: View {
    init() {}

    var body: some View {
        ForEach(0 ... 3, id: \.self) { _ in
            ListRow("Item name", subtitle: "Jan 1, 2026, 12:00 PM")
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    List {
        ___VARIABLE_modelName___PlaceholderView()
    }
}
