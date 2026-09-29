// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___DetailContent: View {
    let ___VARIABLE_categoryVariableName___: ___VARIABLE_categoryName___
    let ___VARIABLE_modelPluralVariableName___: [___VARIABLE_modelName___]
    let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    let onTapCreate___VARIABLE_modelName___: () -> Void
    let on___VARIABLE_modelName___Action: (___VARIABLE_modelName___ListContentView.Action) -> Void

    var body: some View {
        Section("Information") {
            ListRow("Date", subtitle: ___VARIABLE_categoryVariableName___.date.formatted(date: .abbreviated, time: .shortened))

            if let note = ___VARIABLE_categoryVariableName___.note, !note.isEmpty {
                ListRow("Note", subtitle: note)
            }
        }

        if ___VARIABLE_modelPluralVariableName___.isEmpty {
            Section("___VARIABLE_modelName___s") {
                TextBox(
                    title: "Nothing Here Yet",
                    subtitle: "___VARIABLE_modelName___s in this category will appear here"
                )
                .textBoxSize(.small)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.large)
            }
        } else {
            ___VARIABLE_modelName___ListContentView(
                "___VARIABLE_modelName___s",
                ___VARIABLE_modelPluralVariableName___: ___VARIABLE_modelPluralVariableName___,
                ___VARIABLE_categoryPluralVariableName___: ___VARIABLE_categoryPluralVariableName___,
                onAction: on___VARIABLE_modelName___Action
            )
        }

        Section {
            ListButton("Add ___VARIABLE_modelVariableName___", action: onTapCreate___VARIABLE_modelName___)
        }
        .listSectionSpacing(.xxxSmall)
    }
}

#Preview {
    List {
        ___VARIABLE_categoryName___DetailContent(
            ___VARIABLE_categoryVariableName___: .init(name: "Video", emoji: "🎬", color: .red, date: .now, note: "Streaming"),
            ___VARIABLE_modelPluralVariableName___: [.init(name: "Netflix", color: .red, date: .now)],
            ___VARIABLE_categoryPluralVariableName___: [],
            onTapCreate___VARIABLE_modelName___: {},
            on___VARIABLE_modelName___Action: { _ in }
        )
    }
}
