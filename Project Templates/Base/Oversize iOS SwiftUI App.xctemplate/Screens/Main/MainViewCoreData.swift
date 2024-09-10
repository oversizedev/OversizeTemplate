//___FILEHEADER___

import Factory
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeNoticeKit
import OversizeServices
import OversizeUI
import SwiftUI
import TipKit

public struct MainView: View {
    
    @Injected(\.appStateService) var appStateService: AppStateService
    @StateObject var viewModel: MainViewModel
    @Environment(\.screenSize) var screenSize
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var router: Router
    @EnvironmentObject var appSettins: AppSettingsViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: MainViewModel())
    }


    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            NoticeListView()
                .padding(.horizontal, .xxSmall)
                .surfaceRadius(.xLarge)
                .padding(.bottom, .xxSmall)
                .padding(.top, .xxSmall)

            AdView()
                .padding(.horizontal, .xxSmall)
                .surfaceRadius(.xLarge)
                .padding(.vertical, 2)

        }
        .padding(.bottom, .xxSmall)
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
