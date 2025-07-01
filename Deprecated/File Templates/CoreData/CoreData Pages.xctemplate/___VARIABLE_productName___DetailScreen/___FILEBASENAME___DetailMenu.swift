// ___FILEHEADER___

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

extension ___VARIABLE_productName:identifier___DetailView {
    var trailingMenu: some View {
        Menu {
            Button {
                router.move(.update___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: viewModel.___VARIABLE_CoreDataModelVariable___))
            } label: {
                Label {
                    Text(L10n.Button.edit)
                } icon: {
                    Image.Base.edit.icon()
                }
            }
            Button(role: .destructive) {
                router.presentAlert(
                    .delete {
                        delete___VARIABLE_CoreDataModel___Action(viewModel.___VARIABLE_CoreDataModelVariable___)
                        router.back()
                    }
                )
            } label: {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Image.Base.delete.icon(.error)
                }
            }
        } label: {
            Image.Base.more.icon()
        }
    }
}
