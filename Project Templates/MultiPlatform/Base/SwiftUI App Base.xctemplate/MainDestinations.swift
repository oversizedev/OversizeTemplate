//___FILEHEADER___

import Env
import Main
import NavigatorUI
import SwiftUI

extension MainDestinations: @retroactive NavigationDestination {
    @MainActor
    public var body: some View {
        switch self {
        case let .detail(id):
            ___VARIABLE_modelName___Detail.build(input: .init(id: id))
        }
    }
}
