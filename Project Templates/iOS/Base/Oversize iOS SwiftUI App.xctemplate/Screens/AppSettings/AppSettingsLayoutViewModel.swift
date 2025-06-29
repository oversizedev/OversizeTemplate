//___FILEHEADER___

import SwiftUI

@MainActor
class AppSettingsLayoutViewModel: ObservableObject {
    @AppStorage("AppState.Option") var option: String = ""
}
