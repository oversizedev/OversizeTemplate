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
        VStack(spacing: .xxSmall) {
            HStack {
                VStack(alignment: .leading, spacing: .xxxSmall) {
                    Text(___VARIABLE_modelVariableName___.name)
                        .headline(.medium)
                        .foregroundColor(.onSurfacePrimary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                        Text(note)
                            .footnote()
                            .foregroundColor(.onSurfaceSecondary)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer()
                
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 12, height: 12)
            }
            
            HStack {
                Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                    .caption(.medium)
                    .foregroundColor(.onSurfaceSecondary)
                
                Spacer()
                
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.star.icon(.accent, size: .small)
                }
            }
        }
        .padding(.medium)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
