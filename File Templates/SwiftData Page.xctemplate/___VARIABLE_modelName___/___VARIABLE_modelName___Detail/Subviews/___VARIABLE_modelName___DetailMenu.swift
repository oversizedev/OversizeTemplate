// ___FILEHEADER___

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

public struct ___VARIABLE_modelName___DetailMenu: View {
    private let editAction: () -> Void
    private let deleteAction: () -> Void

    public init(
        editAction: @escaping () -> Void,
        deleteAction: @escaping () -> Void
    ) {
        self.editAction = editAction
        self.deleteAction = deleteAction
    }

    public var body: some View {
        Menu {
            Button(action: editAction) {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Image.Base.search.icon()
                }
            }

            Button(action: deleteAction) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.filter.icon()
                }
            }

        } label: {
            Image.Base.more.icon()
        }
    }
}
