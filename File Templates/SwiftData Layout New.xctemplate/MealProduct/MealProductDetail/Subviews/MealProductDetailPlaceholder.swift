// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct MealProductDetailPlaceholder: View {
    init() {}

    var body: some View {
        LeadingVStack {
            Row("Title", subtitle: "Subtitle")
        }
        .redacted(reason: .placeholder)
    }
}
