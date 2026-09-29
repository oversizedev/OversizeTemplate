// ___FILEHEADER___

import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___DetailCover: View {
    let name: String
    let isFavorite: Bool

    var body: some View {
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

struct ___VARIABLE_modelName___DetailCoverBackground: View {
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
                colors: [Color.backgroundPrimary, Color.backgroundTertiary],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    ___VARIABLE_modelName___DetailCover(name: "Netflix", isFavorite: true)
        .frame(height: 200)
        .background {
            ___VARIABLE_modelName___DetailCoverBackground(image: nil)
        }
}
