// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___Menu: View {
    let selected___VARIABLE_categoryName___Id: UUID?
    let ___VARIABLE_categoryPluralVariableName___: [___VARIABLE_categoryName___]
    let onSelect___VARIABLE_categoryName___: (___VARIABLE_categoryName___?) -> Void
    let onTapCreate___VARIABLE_categoryName___: () -> Void

    var body: some View {
        Menu {
            Picker("Category", selection: selection) {
                Text("No Category")
                    .tag(UUID?.none)

                ForEach(___VARIABLE_categoryPluralVariableName___) { ___VARIABLE_categoryVariableName___ in
                    Text(___VARIABLE_categoryVariableName___.name)
                        .tag(UUID?.some(___VARIABLE_categoryVariableName___.id))
                }
            }
            .pickerStyle(.inline)

            Divider()

            Button {
                onTapCreate___VARIABLE_categoryName___()
            } label: {
                Text("Create Category")
            }
        } label: {
            Label {
                Text("Category")
            } icon: {
                Image.Base.Folder.mini
            }
        }
    }

    private var selection: Binding<UUID?> {
        .init(
            get: { selected___VARIABLE_categoryName___Id },
            set: { id in
                onSelect___VARIABLE_categoryName___(___VARIABLE_categoryPluralVariableName___.first { $0.id == id })
            }
        )
    }
}

#Preview {
    Menu("Options") {
        ___VARIABLE_categoryName___Menu(
            selected___VARIABLE_categoryName___Id: nil,
            ___VARIABLE_categoryPluralVariableName___: [
                .init(name: "Entertainment", emoji: "🎬", color: .red, date: .now),
                .init(name: "Music", emoji: "🎧", color: .green, date: .now),
            ],
            onSelect___VARIABLE_categoryName___: { _ in },
            onTapCreate___VARIABLE_categoryName___: {}
        )
    }
}
