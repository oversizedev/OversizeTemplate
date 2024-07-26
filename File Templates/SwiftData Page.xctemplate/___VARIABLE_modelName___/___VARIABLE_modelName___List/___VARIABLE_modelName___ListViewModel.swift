// ___FILEHEADER___

import Database
import Observation
import OversizeCore
import OversizeUI
import SwiftData
import SwiftUI

@Observable
public final class ___VARIABLE_modelName___ListViewModel {
    public var searchTerm: String = ""
    public var isSearch: Bool = false
    public var predicate: Predicate<___VARIABLE_modelName___> = .true
    public var sort: [SortDescriptor<___VARIABLE_modelName___>] = [SortDescriptor(\.name, order: .forward)]
    public var orderSelection: SortOrder = .forward
    public var listSelection: ___VARIABLE_modelName___?

    public init() {}
}
