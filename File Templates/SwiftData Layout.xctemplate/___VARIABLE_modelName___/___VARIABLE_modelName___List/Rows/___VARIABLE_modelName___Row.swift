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
        Row {
            HStack(spacing: .small) {
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading, spacing: .xxxSmall) {
                    Text(___VARIABLE_modelVariableName___.name)
                        .headline(.medium)
                        .foregroundColor(.onSurfacePrimary)
                        .lineLimit(1)
                    
                    if !isCompact {
                        HStack {
                            Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                                .caption(.medium)
                                .foregroundColor(.onSurfaceSecondary)
                            
                            if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                                Text("• \(note)")
                                    .caption(.medium)
                                    .foregroundColor(.onSurfaceSecondary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            if ___VARIABLE_modelVariableName___.isFavorite {
                                Image.Base.star.icon(.accent, size: .small)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        } action: {
            action?()
        }
        #if os(macOS)
        .rowTextColor(isSelected ? Color.onPrimary : Color.onSurfacePrimary)
        #endif
    }
}
