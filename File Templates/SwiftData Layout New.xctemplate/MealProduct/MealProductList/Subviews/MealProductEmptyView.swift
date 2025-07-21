// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct MealProductEmptyView: View {
    @Environment(\.screenSize) var screenSize

    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        ContentView(
            image: nil,
            title: "No meal products",
            subtitle: "Add your first meal product to get started",
            primaryButton: .primary(
                "Add Meal Product",
                action: {
                    action()
                }))
                .padding(.top, .xLarge)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .medium)
                .paddingContent()
                .padding(.top, screenSize.height < 670 ? -70 : 0)
    }
}

#Preview {
    MealProductEmptyView(action: {})
}
