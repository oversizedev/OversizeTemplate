// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Cell: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            // Header with color and status indicators
            HStack {
                RoundedRectangle(cornerRadius: .xxSmall)
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 20, height: 20)
                
                Spacer()
                
                HStack(spacing: .xxSmall) {
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
                }
            }
            
            // Image if available
            if let image = ___VARIABLE_modelVariableName___.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: .small))
            }
            
            // Content
            VStack(alignment: .leading, spacing: .xxSmall) {
                Text(___VARIABLE_modelVariableName___.name)
                    .font(.headline)
                    .foregroundColor(.onSurfacePrimary)
                    .lineLimit(2)
                
                if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                    Text(note)
                        .font(.footnote)
                        .foregroundColor(.onSurfaceSecondary)
                        .lineLimit(3)
                }
                
                Spacer()
                
                // Footer info
                VStack(alignment: .leading, spacing: .xxSmall) {
                    Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.onSurfaceTertiary)
                    
                    if ___VARIABLE_modelVariableName___.viewCount > 0 {
                        HStack(spacing: .xxSmall) {
                            Image.Base.eye
                                .icon(.onSurfaceTertiary)
                                .font(.caption2)
                            Text("\(___VARIABLE_modelVariableName___.viewCount) views")
                                .font(.caption2)
                                .foregroundColor(.onSurfaceTertiary)
                        }
                    }
                }
            }
        }
        .padding(.medium)
        .frame(maxWidth: .infinity, minHeight: 200)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        .onTapGesture(perform: { action?() })
    }
}
