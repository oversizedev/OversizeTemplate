//___FILEHEADER___

import SwiftUI
import SwiftData

@main
struct ___PACKAGENAME:identifier___App: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
