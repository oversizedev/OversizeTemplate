//
// ___FILEBASENAMEASIDENTIFIER___.swift
// Copyright © ___FULLUSERNAME___
// Created on ___DATE___
//

import OversizeCore
import OversizeResources
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    
    @EnvironmentObject var router: Router
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: ___VARIABLE_productName:identifier___DetailViewModel

    init(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___) {
        _viewModel = StateObject(wrappedValue: ___VARIABLE_productName:identifier___DetailViewModel(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___))
    }

    var body: some View {
        PageView(viewModel.___VARIABLE_CoreDataModelVariable___.name.valueOrEmpty) {
            content(viewModel.___VARIABLE_CoreDataModelVariable___)
        }
        .leadingBar { leadingBar }
        .trailingBar { trailingMenu }
        .largeTitle()
    }

    var leadingBar: some View {
        BarButton(.backAction {
            router.back()
        })
    }

    func content(_ ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            if let name = ___VARIABLE_CoreDataModelVariable___.name {
                Row(name)
            }

        }
    }

    func edit___VARIABLE_CoreDataModel___Action(_ ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___) {
        //router.present(.create___VARIABLE_CoreDataModel___(.update(___VARIABLE_CoreDataModelVariable___)))
    }

    func delete___VARIABLE_CoreDataModel___Action(_ ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___) {
        viewContext.delete(___VARIABLE_CoreDataModelVariable___)
        viewContext.saveContext()
    }
}

struct ___FILEBASENAMEASIDENTIFIER____ViewPreviews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.context

        let ___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___.name = "___VARIABLE_CoreDataModel___"
        viewContext.saveContext()

        return ___FILEBASENAMEASIDENTIFIER___(___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModelVariable___).environment(\.managedObjectContext, viewContext)
    }
}
