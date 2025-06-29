// ___FILEHEADER___

import OversizeResources
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___ListMenu: View {
    private let searchAction: () -> Void
    private let filterAction: () -> Void

    public init(
        searchAction: @escaping () -> Void,
        filterAction: @escaping () -> Void
    ) {
        self.searchAction = searchAction
        self.filterAction = filterAction
    }

    public var body: some View {
        Menu {
            Button(action: searchAction) {
                Label {
                    Text("Searth link")
                } icon: {
                    Image.Base.search.icon()
                }
            }

            Button(action: filterAction) {
                Label {
                    Text("Sorting")
                } icon: {
                    Image.Base.filter.icon()
                }
            }

        } label: {
            Image.Base.more.icon()
        }
    }
}
