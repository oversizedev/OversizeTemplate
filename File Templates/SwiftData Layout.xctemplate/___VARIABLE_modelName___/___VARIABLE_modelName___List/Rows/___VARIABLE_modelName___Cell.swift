// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Cell: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let isSelected: Bool
    private let gridSize: ___VARIABLE_modelName___ListGridSize
    private let showImages: Bool
    private let showNotes: Bool
    private let showDates: Bool
    private let isSelectionMode: Bool
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        isSelected: Bool = false,
        gridSize: ___VARIABLE_modelName___ListGridSize = .medium,
        showImages: Bool = true,
        showNotes: Bool = true,
        showDates: Bool = true,
        isSelectionMode: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.isSelected = isSelected
        self.gridSize = gridSize
        self.showImages = showImages
        self.showNotes = showNotes
        self.showDates = showDates
        self.isSelectionMode = isSelectionMode
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .small) {
            imageSection
            
            contentSection
            
            if showDates || ___VARIABLE_modelVariableName___.viewCount > 0 {
                metadataSection
            }
        }
        .padding(.medium)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: cellHeight)
        .background {
            RoundedRectangle(cornerRadius: .medium)
                .fill(Color.surfaceSecondary)
                .overlay {
                    if isSelected {
                        RoundedRectangle(cornerRadius: .medium)
                            .stroke(___VARIABLE_modelVariableName___.color, lineWidth: 2)
                    }
                }
        }
        .overlay(alignment: .topTrailing) {
            overlayContent
        }
        .onTapGesture(perform: { action?() })
    }

    @ViewBuilder
    private var imageSection: some View {
        if showImages {
            Group {
                if let image = ___VARIABLE_modelVariableName___.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    RoundedRectangle(cornerRadius: .small)
                        .fill(___VARIABLE_modelVariableName___.color.gradient)
                }
            }
            .frame(height: imageHeight)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: .small))
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: .xxSmall) {
            Text(___VARIABLE_modelVariableName___.name)
                .font(titleFont)
                .fontWeight(.medium)
                .lineLimit(titleLineLimit)
                .multilineTextAlignment(.leading)
            
            if showNotes, let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                Text(note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(noteLineLimit)
                    .multilineTextAlignment(.leading)
            }
        }
    }

    @ViewBuilder
    private var metadataSection: some View {
        HStack {
            if showDates {
                Text(___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            
            Spacer()
            
            if ___VARIABLE_modelVariableName___.viewCount > 0 {
                HStack(spacing: .xxSmall) {
                    Image.Base.eye
                        .font(.caption2)
                    Text("\(___VARIABLE_modelVariableName___.viewCount)")
                        .font(.caption2)
                }
                .foregroundStyle(.tertiary)
            }
        }
    }

    @ViewBuilder
    private var overlayContent: some View {
        VStack(alignment: .trailing, spacing: .xxSmall) {
            if isSelectionMode {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? ___VARIABLE_modelVariableName___.color : .secondary)
                    .font(.title3)
                    .background(Color.surfaceSecondary)
                    .clipShape(Circle())
            }
            
            if ___VARIABLE_modelVariableName___.isFavorite {
                Image.Base.heart
                    .foregroundStyle(.red)
                    .font(.caption)
            }
        }
        .padding(.small)
    }

    // MARK: - Computed Properties

    private var cellHeight: CGFloat {
        switch gridSize {
        case .small:
            return 180
        case .medium:
            return 220
        case .large:
            return 260
        }
    }

    private var imageHeight: CGFloat {
        switch gridSize {
        case .small:
            return 80
        case .medium:
            return 100
        case .large:
            return 120
        }
    }

    private var titleFont: Font {
        switch gridSize {
        case .small:
            return .caption
        case .medium:
            return .callout
        case .large:
            return .body
        }
    }

    private var titleLineLimit: Int {
        switch gridSize {
        case .small:
            return 1
        case .medium:
            return 2
        case .large:
            return 2
        }
    }

    private var noteLineLimit: Int {
        switch gridSize {
        case .small:
            return 1
        case .medium:
            return 2
        case .large:
            return 3
        }
    }
}
