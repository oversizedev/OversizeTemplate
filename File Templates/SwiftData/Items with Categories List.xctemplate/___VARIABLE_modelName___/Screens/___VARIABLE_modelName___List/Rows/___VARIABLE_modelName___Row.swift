// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___Row: View {
    private let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    private let viewOption: ___VARIABLE_modelName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___,
        viewOption: ___VARIABLE_modelName___ViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_modelVariableName___ = ___VARIABLE_modelVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        ListRow(
            ___VARIABLE_modelVariableName___.name,
            subtitle: viewOption == .compact ? nil : ___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened),
            action: action,
            leading: {
                Circle()
                    .fill(___VARIABLE_modelVariableName___.color)
                    .frame(width: 24, height: 24)
            },
            trailing: {
                if ___VARIABLE_modelVariableName___.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            }
        )
    }
}

#Preview {
    List {
        ___VARIABLE_modelName___Row(.init(name: "Netflix", color: .red, date: .now, isFavorite: true))
        ___VARIABLE_modelName___Row(.init(name: "Spotify", color: .green, date: .now), viewOption: .compact)
    }
}
