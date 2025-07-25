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
        VStack(spacing: .small) {
            headerView
            
            VStack(alignment: .leading, spacing: .xSmall) {
                Text(___VARIABLE_modelVariableName___.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.onSurfacePrimary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                    Text(note)
                        .font(.subheadline)
                        .foregroundColor(.onSurfaceSecondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack {
                    Text(___VARIABLE_modelVariableName___.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.onSurfaceSecondary)
                    
                    Spacer()
                    
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
            .padding(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }

    @ViewBuilder
    private var headerView: some View {
        RoundedRectangle(cornerRadius: .medium, style: .continuous)
            .fill(___VARIABLE_modelVariableName___.color)
            .frame(height: 120)
            .overlay {
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: .medium, style: .continuous))
    }
}
