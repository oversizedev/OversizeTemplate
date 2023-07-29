// ___FILEHEADER___

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    private let editAction: () -> Void
    private let deleteAction: () -> Void

    init(editAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.editAction = editAction
        self.deleteAction = deleteAction
    }

    var body: some View {
        Group {
            Button {
                editAction()
            } label: {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Icon.Line.UserInterface.edit
                        .renderingMode(.template)
                        .foregroundColor(.onSurfaceHighEmphasis)
                }
            }

            Button(role: .destructive) {
                deleteAction()
            } label: {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Icon.Line.UserInterface.trashCan
                        .renderingMode(.template)
                        .foregroundColor(.error)
                }
            }
        }
    }
}
