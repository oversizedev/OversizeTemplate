// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___EmptyView: View {
    @Environment(\.screenSize) var screenSize

    private let filterType: ___VARIABLE_modelName___ListFilterType
    private let action: () -> Void

    public init(
        filterType: ___VARIABLE_modelName___ListFilterType = .standard,
        action: @escaping () -> Void
    ) {
        self.filterType = filterType
        self.action = action
    }

    var body: some View {
        ContentView(
            image: emptyImage,
            title: emptyTitle,
            subtitle: emptySubtitle,
            primaryButton: primaryButton
        )
        .padding(.top, .xLarge)
        .multilineTextAlignment(.center)
        .padding(.horizontal, .medium)
        .paddingContent()
        .padding(.top, screenSize.height < 670 ? -70 : 0)
    }

    // MARK: - Computed Properties

    private var emptyImage: Image? {
        switch filterType {
        case .standard:
            return Illustration.Objects.box
        case .archived:
            return Illustration.Objects.archive
        case .favorites:
            return Illustration.Objects.heart
        }
    }

    private var emptyTitle: String {
        switch filterType {
        case .standard:
            return "No ___VARIABLE_modelPluralVariableName___"
        case .archived:
            return "No archived ___VARIABLE_modelPluralVariableName___"
        case .favorites:
            return "No favorite ___VARIABLE_modelPluralVariableName___"
        }
    }

    private var emptySubtitle: String {
        switch filterType {
        case .standard:
            return "Add your first ___VARIABLE_modelVariableName___ to get started"
        case .archived:
            return "Archive ___VARIABLE_modelPluralVariableName___ to see them here"
        case .favorites:
            return "Add ___VARIABLE_modelPluralVariableName___ to favorites to see them here"
        }
    }

    private var primaryButton: ButtonInfo? {
        switch filterType {
        case .standard:
            return .primary(
                "Add ___VARIABLE_modelName___",
                action: action
            )
        case .archived, .favorites:
            return nil
        }
    }
}

#Preview("Standard") {
    ___VARIABLE_modelName___EmptyView(filterType: .standard, action: {})
}

#Preview("Archived") {
    ___VARIABLE_modelName___EmptyView(filterType: .archived, action: {})
}

#Preview("Favorites") {
    ___VARIABLE_modelName___EmptyView(filterType: .favorites, action: {})
}
