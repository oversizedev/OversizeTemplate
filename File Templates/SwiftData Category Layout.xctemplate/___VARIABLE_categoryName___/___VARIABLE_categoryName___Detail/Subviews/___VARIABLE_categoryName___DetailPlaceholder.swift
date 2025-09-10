// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___DetailPlaceholder: View {
    var body: some View {
        LazyVStack(alignment: .leading, spacing: .large) {
            // Header section placeholder
            VStack(alignment: .leading, spacing: .medium) {
                HStack(spacing: .medium) {
                    Circle()
                        .fill(Color.border)
                        .frame(width: 60, height: 60)
                        .shimmer()

                    VStack(alignment: .leading, spacing: .xxSmall) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.border)
                            .frame(width: 120, height: 20)
                            .shimmer()

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.border)
                            .frame(width: 80, height: 16)
                            .shimmer()
                    }

                    Spacer()
                }
            }

            // Note section placeholder
            VStack(alignment: .leading, spacing: .small) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.border)
                    .frame(width: 60, height: 18)
                    .shimmer()

                VStack(spacing: .xxSmall) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.border)
                        .frame(height: 16)
                        .shimmer()

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.border)
                        .frame(height: 16)
                        .shimmer()

                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.border)
                        .frame(width: 200, height: 16)
                        .shimmer()
                }
            }

            // Details section placeholder
            VStack(alignment: .leading, spacing: .small) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.border)
                    .frame(width: 80, height: 18)
                    .shimmer()

                VStack(spacing: .zero) {
                    ForEach(0 ..< 3, id: \.self) { _ in
                        RowPlaceholder()
                    }
                }
            }
        }
        .paddingContent()
    }
}

#Preview {
    ___VARIABLE_categoryName___DetailPlaceholder()
}