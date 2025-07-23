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
        VStack(alignment: .leading, spacing: .xSmall) {
            HStack {
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 8, height: 8)
                
                Spacer()
                
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.heart.icon(.accent, size: .small)
                }
            }
            
            VStack(alignment: .leading, spacing: .xSmall) {
                Text(___VARIABLE_modelVariableName___.name)
                    .font(.headline)
                    .foregroundStyle(Color.onSurfacePrimary)
                    .multilineTextAlignment(.leading)
                
                if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                    Text(note)
                        .font(.subheadline)
                        .foregroundStyle(Color.onSurfaceSecondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(Color.onSurfaceTertiary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(minHeight: 120)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
