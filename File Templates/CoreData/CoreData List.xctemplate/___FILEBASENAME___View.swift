// ___FILEHEADER___

import CoreData
import OversizeComponents
import OversizeCore
import OversizeKit
import OversizeLocalizable
import OversizeResources
import OversizeServices
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @Environment(\.screenSize) var screenSize
    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var router: Router
    @StateObject var viewModel: ___VARIABLE_productName:identifier___ViewModel

    @State var isSearch: Bool = false

    init() {
        _viewModel = StateObject(wrappedValue: ___VARIABLE_productName:identifier___ViewModel())
    }

    var body: some View {
        LayoutView("___VARIABLE_CoreDataModel___") {
            switch viewModel.state {
            case .result:
            ___VARIABLE_productName:identifier___ListsView(sorting: viewModel.sortingType,
                                 sortingAscending: viewModel.sortingAscending,
                                 searchQuery: $viewModel.searchQuery,
                                 state: $viewModel.state) { ___VARIABLE_CoreDataModelVariable___ in

            ___VARIABLE_productName:identifier___Row(___VARIABLE_CoreDataModelVariable___) {
                        //router.move(.___VARIABLE_CoreDataModelVariable___Detail(___VARIABLE_CoreDataModelVariable___))
                    }
                    .contextMenu {
                    ___VARIABLE_productName:identifier___ContextMenu {
                            edit___VARIABLE_CoreDataModel___Action(___VARIABLE_CoreDataModelVariable___)
                        } deleteAction: {
                            router.presentAlert(.delete___VARIABLE_CoreDataModel___ {
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
        .leadingBar { leadingBar }
        .trailingBar { trailingBar }
        .searchable(text: $viewModel.searchQuery, cancelButton: .icon, isSearch: $isSearch)
        .largeTitle()
    }

    var leadingBar: some View {
        BarButton(.backAction {
            router.back()
        })
    }

    var trailingBar: some View {
        Group {
            BarButton(.icon(.plus, action: {
                create___VARIABLE_CoreDataModel___Action()
            }))

            toolbarMenu
        }
    }

    func showFilterAction() {
        let sheetHeight: CGFloat = 300 + (60 * CGFloat(viewModel.sortingTyps.count))
        /*
        router.present(.___VARIABLE_CoreDataModelVariableMany___Sorting(viewModel.sortingTyps,
                                       selection: $viewModel.sortingType,
                                       ascending: $viewModel.sortingAscending),
                       detents: [.height(sheetHeight)])
         */
    }

    func searchAction() {
        isSearch.toggle()
    }

    func create___VARIABLE_CoreDataModel___Action() {
        //router.present(.create___VARIABLE_CoreDataModel___(.create))
    }

    func edit___VARIABLE_CoreDataModel___Action(_ item: ___VARIABLE_CoreDataModel___) {
        //router.present(.create___VARIABLE_CoreDataModel___(.update(item)))
    }

    func delete___VARIABLE_CoreDataModel___Action(_ item: ___VARIABLE_CoreDataModel___) {
        viewContext.delete(item)
        viewContext.saveContext()
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
