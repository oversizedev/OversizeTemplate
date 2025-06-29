// ___FILEHEADER___

import CoreData
import Database
import Env
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeResources
import OversizeServices
import OversizeUI
import SwiftUI

public struct ___FILEBASENAMEASIDENTIFIER___: View {
    @Environment(\.screenSize) var screenSize
    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var router: Router
    @StateObject var viewModel: ___VARIABLE_productName:identifier___ViewModel
    @State var isSearch: Bool = false

    public init() {
        _viewModel = StateObject(wrappedValue: ___VARIABLE_productName:identifier___ViewModel())
    }

    public var body: some View {
        Page("___VARIABLE_CoreDataModel___") {
            switch viewModel.state {
            case .result:
                ___VARIABLE_productName:identifier___ListsView(
                    sorting: viewModel.sortingType,
                    sortingAscending: viewModel.sortingAscending,
                    searchQuery: $viewModel.searchQuery,
                    state: $viewModel.state
                ) { ___VARIABLE_CoreDataModelVariable___ in
                    ___VARIABLE_productName:identifier___Row(___VARIABLE_CoreDataModelVariable___) {
                        router.move(.detail___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___))
                    }
                    .contextMenu {
                        ___VARIABLE_productName:identifier___ContextMenu {
                            edit___VARIABLE_CoreDataModel___Action(___VARIABLE_CoreDataModelVariable___)
                        } deleteAction: {
                            router.presentAlert(.delete {
                                delete___VARIABLE_CoreDataModel___Action(___VARIABLE_CoreDataModelVariable___)
                            })
                        }
                    }
                }
            case .empty:
                ___VARIABLE_productName:identifier___EmptyView {
                    create___VARIABLE_CoreDataModel___Action()
                }
            }
        }
        .searchable(text: $viewModel.searchQuery, cancelButton: .icon, isSearch: $isSearch)
        .largeTitle()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button  {
                    router.back()
                } label: {
                    Image.Base.arrowLeft.icon()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button  {
                    create___VARIABLE_CoreDataModel___Action()
                } label: {
                    Image.Base.plus.icon()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                toolbarMenu

            }
        }
    }

    func showFilterAction() {
        let sheetHeight: CGFloat = 300 + (60 * CGFloat(viewModel.sortingTyps.count))
        router.present(.sorting___VARIABLE_productName___(
            viewModel.sortingTyps,
            selection: $viewModel.sortingType,
            ascending: $viewModel.sortingAscending),
            detents: [.height(sheetHeight)]
        )
    }

    func searchAction() {
        isSearch.toggle()
    }

    func create___VARIABLE_CoreDataModel___Action() {
        router.move(.create___VARIABLE_productName___)
    }

    func edit___VARIABLE_CoreDataModel___Action(_ item: ___VARIABLE_CoreDataModel___) {
        router.move(.update___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: item))
    }

    func delete___VARIABLE_CoreDataModel___Action(_ item: ___VARIABLE_CoreDataModel___) {
        viewContext.delete(item)
        viewContext.saveContext()
        router.presentHud("Deleted")
    }
}

struct ___FILEBASENAMEASIDENTIFIER____ViewPreviews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.context

        let ___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___.id = UUID()
        ___VARIABLE_CoreDataModelVariable___.name = "Best ___VARIABLE_CoreDataModelVariable___"

        let ___VARIABLE_CoreDataModelVariable___2 = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___2.id = UUID()
        ___VARIABLE_CoreDataModelVariable___2.name = "Best ___VARIABLE_CoreDataModelVariable___"

        viewContext.saveContext()

        return Group {
            ___FILEBASENAMEASIDENTIFIER___()
                .environment(\.managedObjectContext, viewContext)
                .previewDisplayName("Content")
            ___FILEBASENAMEASIDENTIFIER___()
                .previewDisplayName("Empty")
        }
    }
}
