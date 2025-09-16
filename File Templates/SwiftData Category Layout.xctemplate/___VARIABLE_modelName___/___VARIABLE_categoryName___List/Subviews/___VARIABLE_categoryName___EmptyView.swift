//___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

public struct ___VARIABLE_categoryName___EmptyView: View {
    private let filter: ___VARIABLE_categoryName___FilterType
    private let isSearch: Bool
    private let action: () -> Void

    public init(
        filter: ___VARIABLE_categoryName___FilterType,
        isSearch: Bool = false,
        action: @escaping () -> Void
    ) {
        self.filter = filter
        self.isSearch = isSearch
        self.action = action
    }

    public var body: some View {
        VStack(spacing: .large) {
            VStack(spacing: .medium) {
                if let image = filter.emptyStateImage {
                    image
                        .icon(.extraLarge)
                        .foregroundStyle(.tertiary)
                }

                VStack(spacing: .small) {
                    Text(isSearch ? "No Results" : filter.emptyStateTitle)
                        .headline(.medium)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)

                    if let subtitle = filter.emptyStateSubtitle, !isSearch {
                        Text(subtitle)
                            .body(.medium)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    } else if isSearch {
                        Text("Try adjusting your search terms")
                            .body(.medium)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
            }

            if !isSearch && filter == .standard {
                Button(action: action) {
                    HStack(spacing: .small) {
                        Image.Base.Plus.icon(.small)
                        Text("Create ___VARIABLE_categoryName___")
                    }
                    .foregroundStyle(.accent)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .paddingContent()
    }
}