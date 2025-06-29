//___FILEHEADER___

import OversizeUI
import SwiftUI

struct AppSettingsLayoutView: View {
    @StateObject var viewModel: AppSettingsLayoutViewModel

    init() {
        _viewModel = StateObject(wrappedValue: AppSettingsLayoutViewModel())
    }

    var body: some View {
        LayoutView("Option") {
            SectionView {
                VStack(spacing: .zero) {
                    Row("Default option") {
                        Image(systemName: "")
                    }
                }
            }
            .sectionContentCompactRowInsets()
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct AppSettingsLayoutView_ViewPreviews: PreviewProvider {
    static var previews: some View {
        AppSettingsLayoutView()
    }
}
