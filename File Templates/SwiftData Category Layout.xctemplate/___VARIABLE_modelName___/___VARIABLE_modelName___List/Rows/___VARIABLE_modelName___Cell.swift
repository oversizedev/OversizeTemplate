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
        action: (() -> Void)? = nil,
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        VStack(spacing: .small) {
            if let ___VARIABLE_categoryVariableName___ = ___VARIABLE_modelVariableName___.___VARIABLE_categoryVariableName___ {
                HStack {
                    Circle()
                        .fill(___VARIABLE_categoryVariableName___.color)
                        .frame(width: 8, height: 8)
                    
                    Text(___VARIABLE_categoryVariableName___.name)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }

            Text(___VARIABLE_modelVariableName___.name)
                .font(.headline)
                .multilineTextAlignment(.center)

            if viewOption == .standard {
                HStack {
                    Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if ___VARIABLE_modelVariableName___.isFavorite {
                        Image.Base.Star.fill.icon(Color.warning)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
        }
        .onTapGesture(perform: { action?() })
    }
}
