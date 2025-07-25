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
            subtitle: isCompact ? nil : subtitle,
            action: action
        ) {
            HStack(spacing: .small) {
                // Color indicator
                RoundedRectangle(cornerRadius: .xSmall)
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 16, height: 16)
                
                // Image if available
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipShape(RoundedRectangle(cornerRadius: .xSmall))
                }
                
                VStack(alignment: .leading, spacing: .xxSmall) {
                    Text(___VARIABLE_modelVariableName___.name)
                        .font(.body)
                        .foregroundColor(.onSurfacePrimary)
                    
                    if !isCompact {
                        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                            Text(note)
                                .font(.footnote)
                                .foregroundColor(.onSurfaceSecondary)
                                .lineLimit(2)
                        }
                        
                        Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundColor(.onSurfaceTertiary)
                    }
                }
                
                Spacer()
                
                // Status indicators
                HStack(spacing: .xSmall) {
                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Image.Base.heart
                            .icon(.onSurfaceSecondary)
                            .font(.caption)
                    }
                    
                    if ___VARIABLE_modelVariableName___.isArchive {
                        Image.Base.archive
                            .icon(.onSurfaceSecondary)
                            .font(.caption)
                    }
                    
                    if ___VARIABLE_modelVariableName___.viewCount > 0 {
                        HStack(spacing: .xxSmall) {
                            Image.Base.eye
                                .icon(.onSurfaceTertiary)
                                .font(.caption2)
                            Text("\(___VARIABLE_modelVariableName___.viewCount)")
                                .font(.caption2)
                                .foregroundColor(.onSurfaceTertiary)
                        }
                    }
                }
            }
        }
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
    
    private var subtitle: String {
        var components: [String] = []
        
        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
            components.append(note)
        }
        
        components.append(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
        
        return components.joined(separator: " • ")
    }
}
