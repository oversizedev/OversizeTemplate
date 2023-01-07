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
             log("✅ EKEvent fetched")
             state = .result(data)
         case let .failure(error):
            log("❌ EKEvent not fetched (\(error.title))")
             state = .error(error)
         }
         */
    }

    func save() async -> Result<EKEvent, AppError> {
        /*
         let item = EKEvent()
         let result = await calendarService.save(item)
         switch result {
         case let .success(data):
         log("✅ EKEvent saved")
             return .success(data)
         case let .failure(error):
         log("❌ EKEvent not saved (\(error.title))")
             return .failure(error)
         }
         */
        return .failure(.network(type: .unknown))
    }

    func delete(item _: EKEvent) async -> Result<EKEvent, AppError> {
        /*
         let result = await calendarService.delet(item)
         switch result {
         case let .success(data):
            log("✅ EKEvent deleted")
            return .success(data)
         case let .failure(error):
            log("❌ EKEvent not deleted (\(error.title))")
            return .failure(error)
         }
          */
        return .failure(.network(type: .unknown))
    }
}

enum ___FILEBASENAMEASIDENTIFIER___State {
    case initial
    case loading
    case result([EKEvent])
    case error(AppError)
}
