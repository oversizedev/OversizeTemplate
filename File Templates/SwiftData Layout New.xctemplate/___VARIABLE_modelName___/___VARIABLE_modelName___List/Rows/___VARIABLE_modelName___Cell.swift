// ___FILEHEADER___

import Database
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
            if let image = ___VARIABLE_modelVariableName___.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(.small)
            }
            
            VStack(alignment: .leading, spacing: .xxSmall) {
                Text(___VARIABLE_modelVariableName___.name)
                    .headline(.medium)
                    .foregroundColor(.onSurfacePrimary)
                    .lineLimit(2)
                
                if ___VARIABLE_modelVariableName___.calories > 0 {
                    Text("\(Int(___VARIABLE_modelVariableName___.calories)) kcal")
                        .subheadline(.medium)
                        .foregroundColor(.onSurfaceSecondary)
                }
                
                Text(___VARIABLE_modelVariableName___.category)
                    .caption(.medium)
                    .foregroundColor(.onSurfaceTertiary)
            }
            .padding(.horizontal, .small)
            .padding(.bottom, .small)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
