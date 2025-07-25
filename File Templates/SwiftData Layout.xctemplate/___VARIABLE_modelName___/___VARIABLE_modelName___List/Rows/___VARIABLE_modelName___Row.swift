// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let isCompact: Bool
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        isCompact: Bool = false,
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.isCompact = isCompact
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        Row(
            ___VARIABLE_modelVariableName___.name,
            subtitle: subtitle,
            action: action
        )
        .rowBackgroundColor(___VARIABLE_modelVariableName___.color.opacity(0.1))
        .rowAccentColor(___VARIABLE_modelVariableName___.color)
        .rowArrowIcon(.none)
        .leading {
            leadingContent
        }
        .trailing {
            trailingContent
        }
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
        .accessibilityValue(accessibilityValue)
    }
    
    @ViewBuilder
    private var leadingContent: some View {
        HStack(spacing: .xSmall) {
            // Color indicator
            Circle()
                .fill(___VARIABLE_modelVariableName___.color)
                .frame(width: isCompact ? 12 : 16, height: isCompact ? 12 : 16)
            
            // Image if available
            if let image = ___VARIABLE_modelVariableName___.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: isCompact ? 32 : 40, height: isCompact ? 32 : 40)
                    .clipShape(RoundedRectangle(cornerRadius: .xSmall))
            }
        }
    }
    
    @ViewBuilder
    private var trailingContent: some View {
        HStack(spacing: .xSmall) {
            // View count indicator
            if ___VARIABLE_modelVariableName___.viewCount > 0 && viewOption == .standard {
                HStack(spacing: 2) {
                    Image.Base.eye.icon(.onSurfaceMediumEmphasis)
                        .font(.caption2)
                    Text("\(___VARIABLE_modelVariableName___.viewCount)")
                        .font(.caption2)
                        .foregroundColor(.onSurfaceMediumEmphasis)
                }
            }
            
            // Favorite indicator
            if ___VARIABLE_modelVariableName___.isFavorite {
                Image.Base.heart.icon(.red)
                    .font(isCompact ? .caption : .callout)
            }
            
            // Archive indicator
            if ___VARIABLE_modelVariableName___.isArchive {
                Image.Base.archive.icon(.onSurfaceMediumEmphasis)
                    .font(isCompact ? .caption : .callout)
            }
            
            // Date
            if !isCompact {
                Text(___VARIABLE_modelVariableName___.date.formatted(.dateTime.month().day()))
                    .font(.caption)
                    .foregroundColor(.onSurfaceMediumEmphasis)
            }
        }
    }
    
    private var subtitle: String? {
        if isCompact {
            return nil
        }
        
        var subtitleComponents: [String] = []
        
        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
            subtitleComponents.append(note)
        }
        
        if viewOption == .standard {
            subtitleComponents.append(___VARIABLE_modelVariableName___.date.formatted(.dateTime.weekday().month().day().year()))
        }
        
        return subtitleComponents.joined(separator: " • ")
    }
    
    // MARK: - Accessibility
    
    private var accessibilityLabel: String {
        var label = ___VARIABLE_modelVariableName___.name
        if ___VARIABLE_modelVariableName___.isFavorite {
            label += ", favorite"
        }
        if ___VARIABLE_modelVariableName___.isArchive {
            label += ", archived"
        }
        return label
    }
    
    private var accessibilityHint: String {
        "Tap to view details"
    }
    
    private var accessibilityValue: String {
        var value = ""
        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
            value = note
        }
        if ___VARIABLE_modelVariableName___.viewCount > 0 {
            value += value.isEmpty ? "" : ", "
            value += "viewed \(___VARIABLE_modelVariableName___.viewCount) times"
        }
        return value.isEmpty ? nil : value
    }
}
