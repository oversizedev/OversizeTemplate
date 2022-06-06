// ___FILEHEADER___

import OversizeCraft
import OversizeServices
import SwiftUI

@MainActor
class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    @Injected private var ___VARIABLE_productService___: ___VARIABLE_productServiceGlobal___
    @Published var state = ___FILEBASENAMEASIDENTIFIER___State.initial

    func fetchData() async {
        state = .loading
        /*
         let result = await ___VARIABLE_productService___.fetch()
         switch result {
         case let .success(data):
             #if DEBUG
             print("✅ ___VARIABLE_productType___ fetched")
             #endif
             state = .result(data)
         case let .failure(error):
             #if DEBUG
             print("❌ ___VARIABLE_productType___ not fetched (\(error.title))")
             #endif
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
             #if DEBUG
             print("✅ ___VARIABLE_productType___ saved")
             #endif
             return .success(data)
         case let .failure(error):
             #if DEBUG
             print("❌ ___VARIABLE_productType___ not saved (\(error.title))")
             #endif
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
              #if DEBUG
              print("✅ ___VARIABLE_productType___ deleted")
              #endif
             return .success(data)
         case let .failure(error):
             #if DEBUG
             print("❌ ___VARIABLE_productType___ not deleted (\(error.title))")
             #endif
             return .failure(error)
         }
          */
        return .failure(.network(type: .unknown))
    }
}

enum ___FILEBASENAMEASIDENTIFIER___State {
    case initial
    case loading
    case result(___VARIABLE_productType___)
    case error(AppError)
}
