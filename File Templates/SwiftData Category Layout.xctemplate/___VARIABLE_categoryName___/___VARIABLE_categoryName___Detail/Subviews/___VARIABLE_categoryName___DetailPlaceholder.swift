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

public struct ___VARIABLE_categoryName___DetailPlaceholder: View {
    public var body: some View {
        VStack(spacing: .medium) {
            Illustration.Objects.folder
                .icon(.large)
                .foregroundStyle(.secondary)

            Text("Select a ___VARIABLE_categoryVariableName___")
                .headline(.medium)
                .foregroundStyle(.primary)

            Text("Choose a ___VARIABLE_categoryVariableName___ from the list to view its details")
                .body(.medium)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .paddingContent()
    }
}