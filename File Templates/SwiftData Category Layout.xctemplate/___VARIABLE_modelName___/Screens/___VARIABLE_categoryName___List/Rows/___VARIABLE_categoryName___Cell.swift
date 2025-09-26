// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Database
import OversizeCore
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Cell: View {
    private let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        action: (() -> Void)? = nil,
    ) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        VStack {
            Text(___VARIABLE_categoryVariableName___.name)

            if viewOption == .standard {
                HStack {
                    Text(___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .shortened))

                    if ___VARIABLE_categoryVariableName___.isFavorite {
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