// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___PlaceholderView: View {
    init() {}

    var body: some View {
        ForEach(0 ... 3, id: \.self) { _ in
            ListRow("Title", subtitle: "Subtitle")
        }

        .redacted(reason: .placeholder)
    }
}
