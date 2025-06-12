//
// ___FILEBASENAMEASIDENTIFIER___.swift
// Copyright © ___FULLUSERNAME___
// Created on ___DATE___
//

import OversizeCore
import OversizeServices
import OversizeUI
import SwiftUI

@MainActor
class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    // State
    @Published var state = State.result
    @Published var searchQuery: String = .init()

    // Sorting
    @AppStorage("AppSettings.___VARIABLE_CoreDataModel___SortingType") var sortingType: ___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties = .name
    @AppStorage("AppSettings.___VARIABLE_CoreDataModel___SortingAscending") var sortingAscending: Bool = true
    let sortingTyps: [___VARIABLE_CoreDataModel___.___VARIABLE_CoreDataModel___Properties] = [.name]

    init() {}
}

extension ___FILEBASENAMEASIDENTIFIER___ {
    enum State {
        case result, empty
    }
}
