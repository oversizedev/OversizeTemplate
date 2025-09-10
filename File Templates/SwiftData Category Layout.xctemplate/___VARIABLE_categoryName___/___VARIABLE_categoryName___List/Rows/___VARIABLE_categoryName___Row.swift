// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Row: View {
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
            Row(
                ___VARIABLE_categoryVariableName___.name,
                subtitle: subtitle,
                leading: {
                    Circle()
                        .fill(___VARIABLE_categoryVariableName___.color)
                        .frame(width: 16, height: 16)
                },
                trailing: {
                    if ___VARIABLE_categoryVariableName___.isFavorite {
                        Image.Base.Star.mini
                            .foregroundColor(.accent)
                    }
                }
            )
        }
        .buttonStyle(.row)
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
    ___VARIABLE_categoryName___Row(
        .init(
            name: "Sample ___VARIABLE_categoryName___",
            emoji: "📁",
            color: .blue,
            date: Date(),
            note: "Sample note",
            isFavorite: true,
            viewCount: 5,
            index: 0
        ),
        viewOption: .withNote
    ) {}
}