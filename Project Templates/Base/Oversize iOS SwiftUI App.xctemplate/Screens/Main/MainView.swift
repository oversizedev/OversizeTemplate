//___FILEHEADER___

import Factory
import OversizeKit
import OversizeLocalizable
import OversizeServices
import OversizeUI
import SwiftUI

struct MainView: View {
    
    @Injected(\.appStateService) var appStateService: AppStateService
    @Environment(\.screenSize) var screenSize
    @EnvironmentObject var router: Router
    @EnvironmentObject var appSettins: AppSettingsViewModel
    @StateObject var viewModel: MainViewModel

    init() {
        _viewModel = StateObject(wrappedValue: MainViewModel())
    }

    var body: some View {
        Text("Hello, App!")
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
