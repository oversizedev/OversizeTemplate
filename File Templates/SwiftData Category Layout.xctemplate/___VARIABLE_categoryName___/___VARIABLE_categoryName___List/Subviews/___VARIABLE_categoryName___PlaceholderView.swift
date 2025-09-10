// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___PlaceholderView: View {
    let filterType: ___VARIABLE_categoryName___FilterType

    public var body: some View {
        VStack(spacing: .medium) {
            if let image = filterType.emptyStateImage {
                image
                    .icon(.large)
                    .foregroundStyle(.secondary)
            }

            Text(filterType.emptyStateTitle)
                .headline(.medium)
                .foregroundStyle(.primary)

            if let subtitle = filterType.emptyStateSubtitle {
                Text(subtitle)
                    .body(.medium)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .paddingContent()
    }
}