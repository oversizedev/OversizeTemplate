// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Cell: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            // Header with indicators
            HStack {
                // Color indicator
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 12, height: 12)
                
                Spacer()
                
                // Status indicators
                HStack(spacing: .xSmall) {
                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Image.Base.heart.icon(.red)
                            .font(.caption)
                    }
                    
                    if ___VARIABLE_modelVariableName___.isArchive {
                        Image.Base.archive.icon(.onSurfaceMediumEmphasis)
                            .font(.caption)
                    }
                }
            }
            
            // Main content
            VStack(alignment: .leading, spacing: .xxSmall) {
                // Image if available
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: .xSmall))
                }
                
                // Title
                Text(___VARIABLE_modelVariableName___.name)
                    .font(.headline.weight(.medium))
                    .foregroundColor(.onSurfacePrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                // Note if available and in standard view
                if let note = ___VARIABLE_modelVariableName___.note, 
                   !note.isEmpty, 
                   viewOption == .standard {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.onSurfaceMediumEmphasis)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer(minLength: 0)
                
                // Footer info
                HStack {
                    // Date
                    Text(___VARIABLE_modelVariableName___.date.formatted(.dateTime.month().day()))
                        .font(.caption2)
                        .foregroundColor(.onSurfaceMediumEmphasis)
                    
                    Spacer()
                    
                    // View count
                    if ___VARIABLE_modelVariableName___.viewCount > 0 && viewOption == .standard {
                        HStack(spacing: 2) {
                            Image.Base.eye.icon(.onSurfaceMediumEmphasis)
                                .font(.caption2)
                            Text("\(___VARIABLE_modelVariableName___.viewCount)")
                                .font(.caption2)
                                .foregroundColor(.onSurfaceMediumEmphasis)
                        }
                    }
                }
            }
        }
        .padding(.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
                .overlay {
                    RoundedRectangle(cornerRadius: .medium)
                        .stroke(___VARIABLE_modelVariableName___.color.opacity(0.3), lineWidth: 1)
                }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: { action?() })
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("Tap to view details")
        .accessibilityValue(accessibilityValue)
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
    
    private var accessibilityValue: String {
        var components: [String] = []
        
        if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
            components.append(note)
        }
        
        components.append("Created \(___VARIABLE_modelVariableName___.date.formatted(.dateTime.weekday().month().day().year()))")
        
        if ___VARIABLE_modelVariableName___.viewCount > 0 {
            components.append("Viewed \(___VARIABLE_modelVariableName___.viewCount) times")
        }
        
        return components.joined(separator: ", ")
    }
}
