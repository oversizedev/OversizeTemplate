// ___FILEHEADER___

import OversizeResources
import OversizeUI
import SwiftUI

extension ___VARIABLE_productName:identifier___View {
    var toolbarMenu: some View {
        Menu {
            Button {
                create___VARIABLE_CoreDataModel___Action()
            } label: {
                Label {
                    Text("Create ___VARIABLE_CoreDataModelVariable___")
                } icon: {
                    Icon.Line.UserInterface.plusSqFr
                }
            }

            Button {
                searchAction()
            } label: {
                Label {
                    Text("Searth ___VARIABLE_CoreDataModelVariable___")
                } icon: {
                    Icon.Line.UserInterface.search
                }
            }

            Button {
                showFilterAction()
            } label: {
                Label {
                    Text("Sorting")
                } icon: {
                    Icon.Line.ShoppingandEcommerce.filter
                }
            }

        } label: {
            Icon(.moreHorizontal)
        }
        .menuStyle(.barButton)
    }
}
