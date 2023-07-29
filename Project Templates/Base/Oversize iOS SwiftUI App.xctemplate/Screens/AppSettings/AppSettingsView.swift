//___FILEHEADER___

import OversizeUI
import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var viewModel: AppSettingsViewModel

    var body: some View {
        Group {
            NavigationLink(destination: AppSettingsPageView()) {
                Row("Option") {
                    Image(systemName: "")
                }
                .rowArrow()

                .multilineTextAlignment(.leading)
            }
            .buttonStyle(.row)
        }
    }
}

struct AppSettings_ViewPreviews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
