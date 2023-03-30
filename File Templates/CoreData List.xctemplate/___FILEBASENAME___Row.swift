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
    let ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___

    private let action: () -> Void

    public init(_ ___VARIABLE_CoreDataModelVariable___: ___VARIABLE_CoreDataModel___, action: @escaping () -> Void) {
        self.___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModelVariable___
        self.action = action
    }

    var body: some View {
        Row(___VARIABLE_CoreDataModelVariable___.name.valueOrEmpty) {
            action()
        }
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.context

        let ___VARIABLE_CoreDataModelVariable___ = ___VARIABLE_CoreDataModel___(context: viewContext)
        ___VARIABLE_CoreDataModelVariable___.name = "___VARIABLE_CoreDataModel___"
        viewContext.saveContext()

        return ___FILEBASENAMEASIDENTIFIER___(___VARIABLE_CoreDataModelVariable___) {}
            .environment(\.managedObjectContext, viewContext)
            .previewLayout(.sizeThatFits)
    }
}
