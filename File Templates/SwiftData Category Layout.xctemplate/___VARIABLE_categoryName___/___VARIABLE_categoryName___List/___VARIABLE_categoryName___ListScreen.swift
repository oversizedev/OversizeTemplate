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

public struct ___VARIABLE_categoryName___ListScreen: View {
    @Query(___VARIABLE_categoryName___.all) private var ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        NavigationLayoutView("___VARIABLE_categoryPluralVariableName___") {
            if ___VARIABLE_categoryPluralVariableName___.isEmpty {
                emptyView
            } else {
                categoryList
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }

    private var categoryList: some View {
        LazyVStack(spacing: .zero) {
            ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                Row(
                    ___VARIABLE_categoryVariableName___.name,
                    subtitle: "\(___VARIABLE_categoryVariableName___.___VARIABLE_modelVariableName___Count) ___VARIABLE_modelPluralVariableName___",
                    leading: {
                        Circle()
                            .fill(___VARIABLE_categoryVariableName___.color)
                            .frame(width: 16, height: 16)
                    }
                )
            }
        }
        .paddingContent()
    }

    private var emptyView: some View {
        VStack(spacing: .medium) {
            Illustration.Objects.folder
                .icon(.large)
                .foregroundStyle(.secondary)

            Text("No ___VARIABLE_categoryPluralVariableName___ Yet")
                .headline(.medium)
                .foregroundStyle(.primary)

            Text("Create ___VARIABLE_categoryPluralVariableName___ to organize your ___VARIABLE_modelPluralVariableName___")
                .body(.medium)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .paddingContent()
    }
}

public extension ___VARIABLE_categoryName___ListScreen {
    @MainActor
    static func build() -> some View {
        ___VARIABLE_categoryName___ListScreen()
    }
}