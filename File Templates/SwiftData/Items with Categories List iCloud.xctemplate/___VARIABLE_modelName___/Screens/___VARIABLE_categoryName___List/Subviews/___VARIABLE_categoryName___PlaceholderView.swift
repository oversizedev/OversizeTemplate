// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___PlaceholderView: View {
    init() {}

    var body: some View {
        ForEach(0 ... 3, id: \.self) { _ in
            ListRow(
                "Category name",
                subtitle: "Jan 1, 2026, 12:00 PM",
                leading: {
                    Text("🏷️")
                        .frame(width: 24, height: 24, alignment: .center)
                        .iconOnSurface()
                }
            )
            .listRowSeparator(.hidden)
        }
        .redacted(reason: .placeholder)
    }
}
