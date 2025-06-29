//___FILEHEADER___

import OversizeUI
import SwiftUI

public struct AppSettingsView: View {
    @EnvironmentObject var viewModel: AppSettingsViewModel

    public init() {}

    public var body: some View {
        Group {
            NavigationLink(destination: AppSettingsLayoutView()) {
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
