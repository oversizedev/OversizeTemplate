// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___PlaceholderView: View {
    let displayType: ___VARIABLE_modelName___ListDisplayType

    init(displayType: ___VARIABLE_modelName___ListDisplayType) {
        self.displayType = displayType
    }

    var body: some View {
        switch displayType {
        case .list:
            LazyVStack(spacing: .zero) {
                ForEach(0 ... 3, id: \.self) { _ in
                    Row("Title", subtitle: "Subtitle")
                }
            }
            .redacted(reason: .placeholder)
        case .grid:
            LazyVGrid(
                columns: [.init(.adaptive(minimum: 320), spacing: 12)],
                spacing: 12)
            {
                ForEach(0 ... 8, id: \.self) { _ in
                    VStack {
                        Text("Title")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: .medium)
                            .fill(Color.surfaceSecondary)
                    }
                    .redacted(reason: .placeholder)
                }
            }
            .redacted(reason: .placeholder)
        }
    }
}
