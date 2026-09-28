// ___FILEHEADER___

import ___VARIABLE_modelPackage___
import Models
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___DetailContent: View {
    let ___VARIABLE_modelVariableName___: ___VARIABLE_modelName___
    let ___VARIABLE_categoryVariableName___Name: String?

    var body: some View {
        Section("Information") {
            ListRow("Date", subtitle: ___VARIABLE_modelVariableName___.date.formatted(date: .abbreviated, time: .shortened))

            ListRow("Category", subtitle: ___VARIABLE_categoryVariableName___Name ?? "No Category")

            if let note = ___VARIABLE_modelVariableName___.note, !note.isEmpty {
                ListRow("Note", subtitle: note)
            }
        }
    }
}

#Preview {
    List {
        ___VARIABLE_modelName___DetailContent(
            ___VARIABLE_modelVariableName___: .init(name: "Netflix", color: .red, date: .now, note: "Family plan"),
            ___VARIABLE_categoryVariableName___Name: "Video"
        )
    }
}
