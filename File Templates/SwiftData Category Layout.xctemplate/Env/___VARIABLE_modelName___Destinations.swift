// ___FILEHEADER___

import Foundation

public enum ___VARIABLE_modelName___Destinations: Hashable, CaseIterable {
    case ___VARIABLE_modelPluralVariableName___
    case create___VARIABLE_modelName___
    case edit___VARIABLE_modelName___(___VARIABLE_modelName___)
    case detail___VARIABLE_modelName___(___VARIABLE_modelName___)
    case archive___VARIABLE_modelName___s
    case favorites___VARIABLE_modelName___s
    case ___VARIABLE_categoryPluralVariableName___
    case create___VARIABLE_categoryName___
    case edit___VARIABLE_categoryName___(___VARIABLE_categoryName___)
    case detail___VARIABLE_categoryName___(___VARIABLE_categoryName___)
}

public extension ___VARIABLE_modelName___Destinations {
    static var allCases: [___VARIABLE_modelName___Destinations] {
        [
            .___VARIABLE_modelPluralVariableName___,
            .create___VARIABLE_modelName___,
            .archive___VARIABLE_modelName___s,
            .favorites___VARIABLE_modelName___s,
            .___VARIABLE_categoryPluralVariableName___,
            .create___VARIABLE_categoryName___
        ]
    }
}