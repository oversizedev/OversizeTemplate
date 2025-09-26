//
// Copyright © 2025 Alexander Romanov
// MealProductDetailPlaceholder.swift, created on 10.07.2025
//

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
