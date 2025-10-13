// ___FILEHEADER___

import OversizeResources
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___EmptyView: View {
    @State var scrollViewSize: CGSize = .init(width: 0, height: 0)

    let filter: ___VARIABLE_modelName___FilterType
    let isSearch: Bool

    private let action: () -> Void

    init(filter: ___VARIABLE_modelName___FilterType, isSearch: Bool, action: @escaping () -> Void) {
        self.filter = filter
        self.isSearch = isSearch
        self.action = action
    }

    var body: some View {
        ContentView(
            image: image,
            title: title,
            subtitle: subtitle,
            primaryButton: primaryButton,
        )
        .multilineTextAlignment(.center)
        .paddingContent()
        .readScrollViewSize { size in
            Task { @MainActor in
                if size != scrollViewSize {
                    scrollViewSize = size
                }
            }
        }
        .frame(
            width: scrollViewSize.width,
            height: scrollViewSize.height,
        )
    }

    private var image: Image? {
        isSearch ? Illustration.Objects.search : filter.emptyStateImage
    }

    private var title: String {
        isSearch ? "Nothing found" : filter.emptyStateTitle
    }

    private var subtitle: String? {
        isSearch ? "Try changing your search" : filter.emptyStateSubtitle
    }

    private var primaryButton: ContenButtonType? {
        isSearch == false && filter == .standard ? .primary("Add item", action: action) : nil
    }
}

#Preview {
    ___VARIABLE_modelName___EmptyView(
        filter: .standard,
        isSearch: false,
        action: {},
    )
}
