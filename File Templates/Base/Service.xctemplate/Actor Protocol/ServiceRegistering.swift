// ___FILEHEADER___

import Foundation
import OversizeServices
import Factory

___VARIABLE_accessLevel___ extension Container {
    var ___VARIABLE_serviceVariable___Service: Factory<___VARIABLE_productName:identifier___ServiceProtocol> {
         self { ___VARIABLE_productName:identifier___Service() }
     }
}
