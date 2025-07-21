// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let isCompact: Bool
    private let showImages: Bool
    private let showNotes: Bool
    private let showDates: Bool
    private let isSelectionMode: Bool
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        isCompact: Bool = false,
        showImages: Bool = true,
        showNotes: Bool = true,
        showDates: Bool = true,
        isSelectionMode: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.isCompact = isCompact
        self.showImages = showImages
        self.showNotes = showNotes
        self.showDates = showDates
        self.isSelectionMode = isSelectionMode
        self.action = action
    }

    var body: some View {
        Row(
            ___VARIABLE_modelVariableName___.name,
            subtitle: subtitle,
            leading: leadingContent,
            trailing: trailingContent,
            action: action
        )
        .rowStyle(.outline(isSelected ? ___VARIABLE_modelVariableName___.color : .clear))
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }

    @ViewBuilder
    private var leadingContent: some View {
        HStack(spacing: .small) {
            if isSelectionMode {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? ___VARIABLE_modelVariableName___.color : .secondary)
                    .font(.title2)
            }
            
            if showImages {
                Group {
                    if let image = ___VARIABLE_modelVariableName___.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        RoundedRectangle(cornerRadius: .small)
                            .fill(___VARIABLE_modelVariableName___.color)
                    }
                }
                .frame(width: isCompact ? 32 : 44, height: isCompact ? 32 : 44)
                .clipShape(RoundedRectangle(cornerRadius: .small))
            }
        }
    }

    @ViewBuilder
    private var trailingContent: some View {
        VStack(alignment: .trailing, spacing: .xxSmall) {
            if ___VARIABLE_modelVariableName___.isFavorite {
                Image.Base.heart
                    .foregroundStyle(.red)
                    .font(.caption)
            }
            
            if showDates && !isCompact {
                Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            if ___VARIABLE_modelVariableName___.viewCount > 0 {
                HStack(spacing: .xxSmall) {
                    Image.Base.eye
                        .font(.caption2)
                    Text("\(___VARIABLE_modelVariableName___.viewCount)")
                        .font(.caption2)
                }
                .foregroundStyle(.tertiary)
            }
        }
    }

    private var subtitle: String? {
        if isCompact { return nil }
        
        var components: [String] = []
        
        if showNotes, let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
            components.append(note)
        }
        
        if showDates {
            components.append(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
        }
        
        return components.isEmpty ? nil : components.joined(separator: " • ")
    }
}
