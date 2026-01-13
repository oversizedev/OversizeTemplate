//___FILEHEADER___

import Env
import OversizeRouter
import SwiftUI

public struct RootView: View {
    public init() {}

    public var body: some View {
        RoutingView<Text, Screen> {
            Text("Root")
        }
        .coreServices()
    }
}
