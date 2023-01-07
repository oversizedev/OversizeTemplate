//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeResources
import OversizeServices
import OversizeUI
import SwiftUI

struct MainView: View {
    
    @Environment(\.screenSize) var screenSize
    @EnvironmentObject var router: Router
    @EnvironmentObject var appSettins: AppSettingsViewModel
    @StateObject var viewModel: MainViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: ___VARIABLE_CoreDataModelName___.all) var items: FetchedResults<___VARIABLE_CoreDataModelName___>

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