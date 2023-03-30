//
// ___FILEBASENAMEASIDENTIFIER___.swift
// Copyright © ___FULLUSERNAME___
// Created on ___DATE___
//

import OversizeComponents
import OversizeUI
import SwiftUI

struct ___FILEBASENAMEASIDENTIFIER___: View {
    var typs: [___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties]
    @Binding var sortingType: ___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties
    @Binding var ascending: Bool

    init(_ sortingTyps: [___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties], selection: Binding<___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties>, ascending: Binding<Bool>) {
        typs = sortingTyps
        _sortingType = selection
        _ascending = ascending
    }

    var body: some View {
        SortingPicker(Text("Sort by"), typs, selection: $sortingType, ascending: $ascending) { item, isSelected in
            Radio(item.rawValue.capitalized, isOn: isSelected)
        } action: { selected in
            sortingType = selected
        }
    }
}

struct ___FILEBASENAMEASIDENTIFIER____Previews: PreviewProvider {
    static var previews: some View {
        ___FILEBASENAMEASIDENTIFIER___([.name], selection: .constant(.name), ascending: .constant(true))
    }
}
