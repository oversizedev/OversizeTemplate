// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___DetailCover: View {
    let emoji: String
    let name: String
    let isFavorite: Bool

    var body: some View {
        VStack(spacing: .xSmall) {
            Text(emoji)
                .font(.system(size: 48))
                .padding(.large)
                .background {
                    Circle()
                        .fill(Color.surfacePrimary)
                }

            HStack(spacing: .xxxSmall) {
                Text(name)
                    .title3()
                    .onSurfacePrimary()
                    .multilineTextAlignment(.center)

                if isFavorite {
                    Image.Base.Star.fill.icon(Color.warning)
                }
            }
        }
    }
}

struct ___VARIABLE_categoryName___DetailCoverBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color.backgroundPrimary, Color.backgroundSecondary],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#Preview {
    ___VARIABLE_categoryName___DetailCover(emoji: "🎬", name: "Video", isFavorite: true)
        .frame(height: 200)
        .background {
            ___VARIABLE_categoryName___DetailCoverBackground()
        }
}
