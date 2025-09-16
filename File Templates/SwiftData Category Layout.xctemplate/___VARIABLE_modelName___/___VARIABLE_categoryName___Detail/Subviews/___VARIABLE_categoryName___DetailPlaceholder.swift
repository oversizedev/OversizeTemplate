//___FILEHEADER___

import OversizeUI
import SwiftUI

public struct ___VARIABLE_categoryName___DetailPlaceholder: View {
    public init() {}

    public var body: some View {
        VStack(spacing: .large) {
            // Cover placeholder
            Rectangle()
                .fill(.regularMaterial)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .redacted(reason: .placeholder)
            
            VStack(spacing: .medium) {
                // Name placeholder
                HStack {
                    Text("Name")
                        .body(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 120, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
                // Note placeholder
                HStack {
                    Text("Note")
                        .body(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 200, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
                // Items count placeholder
                HStack {
                    Text("Items")
                        .body(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 80, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
                // Color placeholder
                HStack {
                    Text("Color")
                        .body(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    HStack {
                        Circle()
                            .fill(.regularMaterial)
                            .frame(width: 24, height: 24)
                        Rectangle()
                            .fill(.regularMaterial)
                            .frame(width: 100, height: 20)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
                
                // Created date placeholder
                HStack {
                    Text("Created")
                        .body(.medium)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Rectangle()
                        .fill(.regularMaterial)
                        .frame(width: 100, height: 20)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
            .paddingContent()
            
            Spacer()
        }
        .redacted(reason: .placeholder)
    }
}