//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeCore
import OversizeResources
import OversizeUI
import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var viewModel: AppSettingsViewModel

    var body: some View {
        Group {
            NavigationLink(destination: EmptyView()) {
                Row("Default calendar")
                    .rowLeading(.image(Icon.Line.DateandTime.calendar02))
                    .rowTrailing(.arrowIcon)
                    .multilineTextAlignment(.leading)
            }
            .buttonStyle(.row)
        }
    }
}

struct AppSettingsView_ViewPreviews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
