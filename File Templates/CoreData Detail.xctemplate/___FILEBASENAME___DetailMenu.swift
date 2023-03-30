//
// ___FILEBASENAMEASIDENTIFIER___.swift
// Copyright © ___FULLUSERNAME___
// Created on ___DATE___
//

import OversizeLocalizable
import OversizeResources
import OversizeUI
import SwiftUI

extension ___VARIABLE_productName:identifier___DetailView {
    var trailingMenu: some View {
        Menu {
            Button {
                //router.present(.create___VARIABLE_CoreDataModel___(.update(viewModel.___VARIABLE_CoreDataModelVariable___)))
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
                router.presentAlert(
                    .delete___VARIABLE_CoreDataModel___ {
                        delete___VARIABLE_CoreDataModel___Action(viewModel.___VARIABLE_CoreDataModelVariable___)
                        router.back()
                    }
                )
            } label: {
                Label {
                    Text(L10n.Button.delete)
                } icon: {
                    Icon.Line.UserInterface.trashCan
                        .renderingMode(.template)
                        .foregroundColor(.error)
                }
            }

        } label: {
            Icon(.moreHorizontal)
        }
        .menuStyle(.barButton)
    }
}
