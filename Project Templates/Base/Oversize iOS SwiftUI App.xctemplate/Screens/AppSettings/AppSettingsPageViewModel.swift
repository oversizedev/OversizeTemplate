//___FILEHEADER___

import SwiftUI

@MainActor
class AppSettingsPageViewModel: ObservableObject {
    @AppStorage("AppState.Option") var option: String = ""
}
