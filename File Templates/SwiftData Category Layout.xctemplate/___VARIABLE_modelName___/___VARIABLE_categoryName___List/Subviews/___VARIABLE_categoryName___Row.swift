//___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

public struct ___VARIABLE_categoryName___Row: View {
    private let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let action: () -> Void

    public init(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        action: @escaping () -> Void
    ) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: .medium) {
                leadingContent
                
                VStack(alignment: .leading, spacing: .xSmall) {
                    HStack {
                        Text(___VARIABLE_categoryVariableName___.name)
                            .headline(.medium)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        if ___VARIABLE_categoryVariableName___.isFavorite {
                            Image.Base.Star.mini
                                .foregroundStyle(.accent)
                        }
                    }
                    
                    if viewOption == .standard {
                        HStack {
                            Text("\(___VARIABLE_categoryVariableName___.___VARIABLE_modelVariableName___Count) ___VARIABLE_modelPluralVariableName___")
                                .body(.medium)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                        }
                        
                        if let note = ___VARIABLE_categoryVariableName___.note, !note.isEmpty {
                            HStack {
                                Text(note)
                                    .caption(.medium)
                                    .foregroundStyle(.tertiary)
                                    .lineLimit(2)
                                
                                Spacer()
                            }
                        }
                    }
                }
                
                trailingContent
            }
            .padding(.horizontal, .medium)
            .padding(.vertical, viewOption == .compact ? .small : .medium)
            .background(Color.surfacePrimary)
            .clipShape(RoundedRectangle(cornerRadius: .medium))
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var leadingContent: some View {
        ZStack {
            Circle()
                .fill(___VARIABLE_categoryVariableName___.color)
                .frame(width: viewOption == .compact ? 32 : 40, height: viewOption == .compact ? 32 : 40)
            
            if let emoji = ___VARIABLE_categoryVariableName___.emoji {
                Text(emoji)
                    .font(.system(size: viewOption == .compact ? 16 : 20))
            } else {
                Image.Objects.Folder.icon(viewOption == .compact ? .small : .medium)
                    .foregroundStyle(.white)
            }
        }
    }
    
    @ViewBuilder
    private var trailingContent: some View {
        if viewOption == .standard {
            VStack(alignment: .trailing, spacing: .xSmall) {
                Text(___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                    .caption(.medium)
                    .foregroundStyle(.tertiary)
                
                if ___VARIABLE_categoryVariableName___.viewCount > 0 {
                    HStack(spacing: .xSmall) {
                        Image.Base.Eye.mini
                            .foregroundStyle(.tertiary)
                        Text("\(___VARIABLE_categoryVariableName___.viewCount)")
                            .caption(.medium)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
    }
}