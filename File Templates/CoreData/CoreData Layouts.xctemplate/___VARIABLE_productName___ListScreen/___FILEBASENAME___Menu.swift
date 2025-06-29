// ___FILEHEADER___

import OversizeResources
import OversizeUI
import SwiftUI

extension ___VARIABLE_productName:identifier___Screen {
    var toolbarMenu: some View {
        Menu {
            Button {
                create___VARIABLE_CoreDataModel___Action()
            } label: {
                Label {
                    Text("Create ___VARIABLE_CoreDataModelVariable___")
                } icon: {
                    Image.Base.plus.icon()
                }
            }

            Button {
                searchAction()
            } label: {
                Label {
                    Text("Searth ___VARIABLE_CoreDataModelVariable___")
                } icon: {
                    Image.Base.search.icon()
                }
            }

            Button {
                showFilterAction()
            } label: {
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
