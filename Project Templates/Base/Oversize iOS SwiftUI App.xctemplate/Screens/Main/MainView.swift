//___FILEHEADER___

import Factory
import OversizeKit
import OversizeNoticeKit
import OversizeLocalizable
import OversizeServices
import OversizeCore
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
        Page {
            VStack(spacing: .zero) {
                
                NoticeListView()

                AdView()
            }
        }
        .backgroundSecondary()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Home")
                    .font(.headline)
                    .onBackgroundHighEmphasisForegroundColor()
            }
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
