//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import OversizeCore
import OversizeServices
import OversizeCalendarService
import EventKit
import SwiftUI

@MainActor
class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    @Injected(Container.calendarService) private var calendarService: CalendarService
    @Published var state = ___FILEBASENAMEASIDENTIFIER___State.initial
    @Published var sheet: ___FILEBASENAMEASIDENTIFIER___.Sheet? = nil

    func fetchData() async {
        state = .loading
        /*
         let result = await calendarService.fetch()
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
         let result = await calendarService.save(item)
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
         let result = await calendarService.delet(item)
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
