// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___DetailPlaceholder: View {
    init() {}

    var body: some View {
        ListSection("Information") {
            ListRow("Name", subtitle: "Category name")
            ListRow("Note", subtitle: "Some note text here")
        }
        .listSectionTitlePosition(.inside)

        ListSection {
            ForEach(0 ... 2, id: \.self) { _ in
                ListRow("Item name", subtitle: "Jan 1, 2026, 12:00 PM")
                    .listRowSeparator(.hidden)
            }
        }
        .redacted(reason: .placeholder)
    }
}