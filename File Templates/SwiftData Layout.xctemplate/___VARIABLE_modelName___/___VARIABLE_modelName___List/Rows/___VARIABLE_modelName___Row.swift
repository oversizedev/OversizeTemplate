// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let isCompact: Bool
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        isCompact: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.isCompact = isCompact
        self.action = action
    }

    var body: some View {
        Row(
            ___VARIABLE_modelVariableName___.name,
            subtitle: isCompact ? nil : ___VARIABLE_modelVariableName___.note,
            leading: {
                leadingView
            },
            trailing: {
                trailingView
            },
            action: action
        )
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }

    @ViewBuilder
    private var leadingView: some View {
        Circle()
            .fill(___VARIABLE_modelVariableName___.color)
            .frame(width: 32, height: 32)
    }

    @ViewBuilder
    private var trailingView: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(___VARIABLE_modelVariableName___.date, style: .date)
                .font(.caption)
                .foregroundColor(.onSurfaceSecondary)
            
            HStack(spacing: 4) {
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.star.icon(.warning, size: .xSmall)
                }
                if ___VARIABLE_modelVariableName___.isArchive {
                    Image.Base.archive.icon(.onSurfaceSecondary, size: .xSmall)
                }
            }
        }
    }
}
