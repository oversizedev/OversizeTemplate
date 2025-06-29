// ___FILEHEADER___

import Database
import Env
import OversizeLocalizable
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var router: Router
    @State var state: ___VARIABLE_productName:identifier___ViewModel.State = .result

    var body: some View {
        SectionView("___VARIABLE_productName:identifier___") {
            ___VARIABLE_productName:identifier___ListsView(
                sorting: .name,
                sortingAscending: true,
                searchQuery: .constant(.init()),
                state: $state,
                limit: 4) { ___VARIABLE_CoreDataModelVariable___ in
                    ___VARIABLE_CoreDataModelVariable___Row(___VARIABLE_CoreDataModelVariable___)
                }
        }
        .sectionTitleButton(.arrow {
            router.move(.list___VARIABLE_productName___)
        })
        .sectionTitlePosition(.inside)
        .sectionViewStyle(.smallIndent)
        .controlRadius(.xLarge)
    }
    
    func ___VARIABLE_CoreDataModelVariable___Row(_ ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___) -> some View {
        ___VARIABLE_productName:identifier___Row(___VARIABLE_CoreDataModelVariable___) {
            router.move(.detail___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___))
        }
        .rowContentMargins(.init(
            top: .xSmall,
            leading: .medium,
            bottom: .xSmall,
            trailing: .medium
        ))
        .contextMenu {
            ___VARIABLE_productName:identifier___ContextMenu {
                router.move(.update___VARIABLE_productName___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___))
            } deleteAction: {
                router.presentAlert(
                    .delete {
                        delete___VARIABLE_CoreDataModel___Action(___VARIABLE_CoreDataModelVariable___)
                    }
                )
            }
        }
    }

    func delete___VARIABLE_CoreDataModel___Action(_ item: ___VARIABLE_CoreDataModel___) {
        viewContext.delete(item)
        viewContext.saveContext()
        router.presentHud("Deleted")
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.context

        let ___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___.id = UUID()
        ___VARIABLE_CoreDataModelVariable___.name = "Name"

        let ___VARIABLE_CoreDataModelVariable___2 = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___2.id = UUID()
        ___VARIABLE_CoreDataModelVariable___2.name = "Best ___VARIABLE_CoreDataModelVariable___"

        viewContext.saveContext()

        return Group {
            ___FILEBASENAMEASIDENTIFIER___()
                .environment(\.managedObjectContext, viewContext)
                .previewDisplayName("Content")
                .previewLayout(.sizeThatFits)

            ___FILEBASENAMEASIDENTIFIER___()
                .previewDisplayName("Empty")
                .previewLayout(.sizeThatFits)
        }
        .padding(.vertical, .small)
        .background(Color.backgroundSecondary)
    }
}
