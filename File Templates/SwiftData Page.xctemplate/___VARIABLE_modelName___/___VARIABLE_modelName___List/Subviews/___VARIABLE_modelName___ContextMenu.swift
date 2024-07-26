// ___FILEHEADER___

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

struct ___VARIABLE_modelName___ContextMenu: View {
    private let editAction: () -> Void
    private let deleteAction: () -> Void
    private let compactRowAction: (() -> Void)?
    private let favoriteAction: (() -> Void)?
    private let archiveAction: (() -> Void)?

    init(
        editAction: @escaping () -> Void,
        compactRowAction: (() -> Void)?,
        favoriteAction: (() -> Void)?,
        archiveAction: (() -> Void)?,
        deleteAction: @escaping () -> Void
    ) {
        self.editAction = editAction
        self.compactRowAction = compactRowAction
        self.favoriteAction = favoriteAction
        self.archiveAction = archiveAction
        self.deleteAction = deleteAction
    }

    var body: some View {
        Group {
            Button(action: editAction) {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Image.Base.edit.icon()
                }
            }

            if let compactRowAction {
                Button(action: compactRowAction) {
                    Label {
                        Text("Compact row")
                    } icon: {
                        Image.GridsAndLayout.list.icon()
                    }
                }
            }

            if let favoriteAction {
                Button(action: favoriteAction) {
                    Label {
                        Text("Favorite")
                    } icon: {
                        Image.Star.star.icon()
                    }
                }
            }

            if let archiveAction {
                Button(action: archiveAction) {
                    Label {
                        Text("Archive")
                    } icon: {
                        Image.Delivery.delivery.icon()
                    }
                }
            }

            Button(role: .destructive, action: deleteAction) {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.delete.icon(.error)
                }
            }
        }
    }
}
