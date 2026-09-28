// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Row: View {
    private let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    private let viewOption: ___VARIABLE_categoryName___ViewOption
    private let action: (() -> Void)?

    init(
        _ ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___,
        viewOption: ___VARIABLE_categoryName___ViewOption = .standard,
        action: (() -> Void)? = nil
    ) {
        self.___VARIABLE_categoryVariableName___ = ___VARIABLE_categoryVariableName___
        self.viewOption = viewOption
        self.action = action
    }

    var body: some View {
        ListRow(
            ___VARIABLE_categoryVariableName___.name,
            subtitle: viewOption == .compact ? nil : ___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .shortened),
            action: action,
            leading: {
                Text(___VARIABLE_categoryVariableName___.displayEmoji)
                    .frame(width: 24, height: 24, alignment: .center)
                    .iconOnSurface(surfaceSolor: ___VARIABLE_categoryVariableName___.color.opacity(0.2))
            },
            trailing: {
                if ___VARIABLE_categoryVariableName___.isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            }
        )
    }
}

#Preview {
    List {
        ___VARIABLE_categoryName___Row(.init(name: "Video", emoji: "🎬", color: .red, date: .now, isFavorite: true))
        ___VARIABLE_categoryName___Row(.init(name: "Music", emoji: nil, color: .blue, date: .now), viewOption: .compact)
    }
}
