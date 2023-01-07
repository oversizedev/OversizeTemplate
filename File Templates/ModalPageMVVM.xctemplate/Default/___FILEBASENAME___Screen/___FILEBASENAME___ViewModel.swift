// ___FILEHEADER___

import OversizeCore
import OversizeServices
import SwiftUI
import ___VARIABLE_importService___

@MainActor
class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    @Injected(Container.___VARIABLE_productService___) private var ___VARIABLE_productService___: ___VARIABLE_productServiceGlobal___
    @Published var state = ___FILEBASENAMEASIDENTIFIER___State.initial

    func fetchData() async {
        state = .loading
        /*
         let result = await ___VARIABLE_productService___.fetch()
         switch result {
         case let .success(data):
             log("✅ ___VARIABLE_productType___ fetched")
             state = .result(data)
         case let .failure(error):
            log("❌ ___VARIABLE_productType___ not fetched (\(error.title))")
             state = .error(error)
         }
         */
    }

    func save() async -> Result<___VARIABLE_productType___, AppError> {
        /*
         let item = ___VARIABLE_productType___()
         let result = await ___VARIABLE_productService___.save(item)
         switch result {
         case let .success(data):
         log("✅ ___VARIABLE_productType___ saved")
             return .success(data)
         case let .failure(error):
         log("❌ ___VARIABLE_productType___ not saved (\(error.title))")
             return .failure(error)
         }
         */
        return .failure(.network(type: .unknown))
    }

    func delete(item _: ___VARIABLE_productType___) async -> Result<___VARIABLE_productType___, AppError> {
        /*
         let result = await cloudKitService.delet(item)
         switch result {
         case let .success(data):
            log("✅ ___VARIABLE_productType___ deleted")
            return .success(data)
         case let .failure(error):
            log("❌ ___VARIABLE_productType___ not deleted (\(error.title))")
            return .failure(error)
         }
          */
        return .failure(.network(type: .unknown))
    }
}

enum ___FILEBASENAMEASIDENTIFIER___State {
    case initial
    case loading
    case result([___VARIABLE_productType___])
    case error(AppError)
}
