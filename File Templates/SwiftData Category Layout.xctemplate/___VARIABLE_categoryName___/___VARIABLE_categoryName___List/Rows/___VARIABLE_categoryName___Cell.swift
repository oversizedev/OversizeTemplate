// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Cell: View {
    private let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let action: () -> Void

    init(_ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___, viewOption: ___VARIABLE_categoryName___ViewOption, action: @escaping () -> Void) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: .small) {
                Circle()
                    .fill(___VARIABLE_categoryVariableName___.color)
                    .frame(width: 40, height: 40)
                    .overlay {
                        if ___VARIABLE_categoryVariableName___.isFavorite {
                            Image.Base.Star.mini
                                .foregroundColor(.onSurfaceHighEmphasis)
                        }
                    }

                VStack(spacing: .xxxSmall) {
                    Text(___VARIABLE_categoryVariableName___.name)
                        .headline(.small)
                        .foregroundColor(.onSurfaceHighEmphasis)
                        .multilineTextAlignment(.center)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .caption(.medium)
                            .foregroundColor(.onSurfaceDisabled)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding(.medium)
            .background(Color.surfacePrimary, in: RoundedRectangle(cornerRadius: .medium))
        }
        .buttonStyle(.cell)
    }

    private var subtitle: String? {
        switch viewOption {
        case .withoutNote:
            nil
        case .withNote:
            ___VARIABLE_categoryVariableName___.note
        }
    }
}

#Preview {
    ___VARIABLE_categoryName___Cell(
        .init(
            name: "Sample ___VARIABLE_categoryName___",
            color: .blue,
            date: Date(),
            note: "Sample note",
            isFavorite: true,
            viewCount: 5
        ),
        viewOption: .withNote
    ) {}
    .frame(width: 120)
}