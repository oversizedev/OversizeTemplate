// ___FILEHEADER___

import SwiftData
import OversizeCore

public extension InjectionKey {
    static var ___VARIABLE_categoryVariableName___StorageService: InjectionKey<___VARIABLE_categoryName___StorageService> {
        InjectionKey()
    }
}

public extension InjectionValues {
    var ___VARIABLE_categoryVariableName___StorageService: ___VARIABLE_categoryName___StorageService {
        get { Self[InjectionKey.___VARIABLE_categoryVariableName___StorageService] }
        set { Self[InjectionKey.___VARIABLE_categoryVariableName___StorageService] = newValue }
    }
}