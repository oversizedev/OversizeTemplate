// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_categoryName___DetailCover: View {
    let emoji: String
    let name: String
    let color: Color
    let isFavorite: Bool

    var body: some View {
        VStack(spacing: .xSmall) {
            Text(emoji)
                .font(.system(size: 48))
                .padding(.large)
                .background {
                    Circle()
                        .fill(color.opacity(0.2))
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
    let image: Image?

    var body: some View {
        if let image {
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
        } else {
            LinearGradient(
                colors: [Color.backgroundPrimary, Color.backgroundSecondary],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    ___VARIABLE_categoryName___DetailCover(emoji: "🎬", name: "Video", color: .red, isFavorite: true)
        .frame(height: 200)
        .background {
            ___VARIABLE_categoryName___DetailCoverBackground(image: nil)
        }
}
