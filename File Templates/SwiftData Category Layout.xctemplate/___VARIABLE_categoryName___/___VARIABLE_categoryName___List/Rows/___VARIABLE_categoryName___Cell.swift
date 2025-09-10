// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNavigation
import OversizeUI
import SwiftData
import SwiftUI

public struct ___VARIABLE_categoryName___Cell: View {
    let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___

    public var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            HStack {
                Circle()
                    .fill(___VARIABLE_categoryVariableName___.color)
                    .frame(width: 12, height: 12)
                
                Spacer()
                
                Text("\(___VARIABLE_categoryVariableName___.___VARIABLE_modelPluralVariableName___.count)")
                    .caption(.medium)
                    .foregroundStyle(.secondary)
            }
            
            Text(___VARIABLE_categoryVariableName___.name)
                .headline(.small)
                .foregroundStyle(.primary)
                .lineLimit(2)
            
            Spacer(minLength: 0)
        }
        .padding(.medium)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: .medium))
    }
}