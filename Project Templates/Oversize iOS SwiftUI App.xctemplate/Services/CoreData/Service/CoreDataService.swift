//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import CoreData
import Foundation
import OversizeCore
import OversizeCoreData
import OversizeServices
import SwiftUI

public class ___PACKAGENAME:identifier___CoreDataService {
    public init() {}

    var dbHelper: CoreDataHelper = .shared
}

public extension ___PACKAGENAME:identifier___CoreDataService {
    func add___VARIABLE_CoreDataModelName___(id: UUID = UUID(), name: String, date: Date = Date()) async -> Result<___VARIABLE_CoreDataModelName___, AppError> {
        do {
            let entity = ___VARIABLE_CoreDataModelName___.entity()
            let new___VARIABLE_CoreDataModelName___: ___VARIABLE_CoreDataModelName___ = .init(entity: entity, insertInto: dbHelper.context)
            new___VARIABLE_CoreDataModelName___.id = id
            new___VARIABLE_CoreDataModelName___.name = name
            new___VARIABLE_CoreDataModelName___.date = date
            try await dbHelper.create(new___VARIABLE_CoreDataModelName___)
            return .success(new___VARIABLE_CoreDataModelName___)
        } catch {
            return .failure(.coreData(type: .savingItem))
        }
    }

    func update___VARIABLE_CoreDataModelName___(_ item: ___VARIABLE_CoreDataModelName___, name: String? = nil, date: Date? = nil) async -> Result<Bool, AppError> {
        do {
            var updatItem = item
            if let name {
                updatItem.name = name
            }
            if let date {
                updatItem.date = date
            }
            try await dbHelper.update(updatItem)
            return .success(true)
        } catch {
            return .failure(.coreData(type: .savingItem))
        }
    }

    func delete___VARIABLE_CoreDataModelName___(_ item: ___VARIABLE_CoreDataModelName___) async -> Result<Bool, AppError> {
        do {
            try await dbHelper.delete(item)
            return .success(true)
        } catch {
            return .failure(.coreData(type: .deleteItem))
        }
    }
}
