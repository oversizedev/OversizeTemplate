//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import CoreData
import Foundation
import OversizeCoreData
import OversizeServices

public class CoreDataHelper: DBHelperProtocol {
    public static let shared: CoreDataHelper = .init()

    public typealias ObjectType = NSManagedObject
    public typealias PredicateType = NSPredicate

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    // MARK: -  DBHelper Protocol

    public func create(_: NSManagedObject) async throws {
        try await context.perform {
            do {
                try self.context.save()
            } catch {
                throw AppError.coreData(type: .savingItem)
            }
        }
    }

    public func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil, sort: [NSSortDescriptor]? = nil) async throws -> Result<[T], AppError> {
        await context.perform {
            let request = objectType.fetchRequest()
            request.predicate = predicate
            request.sortDescriptors = sort ?? [NSSortDescriptor(key: "date", ascending: false)]
            if let limit {
                request.fetchLimit = limit
            }
            do {
                let result = try self.context.fetch(request)
                return .success(result as? [T] ?? [])
            } catch {
                return .failure(.coreData(type: .unknown))
            }
        }
    }

    public func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) async throws -> Result<T?, AppError> {
        await context.perform {
            let request = objectType.fetchRequest()
            request.predicate = predicate
            request.fetchLimit = 1
            do {
                let result = try self.context.fetch(request) as? [T]
                return .success(result?.first)
            } catch {
                return .failure(.coreData(type: .fetchItems))
            }
        }
    }

    public func update(_: NSManagedObject) async throws {
        try await context.perform {
            try self.context.save()
        }
    }

    public func delete(_ object: NSManagedObject) async throws {
        await context.perform {
            self.context.delete(object)
        }
        try await save()
    }

    // MARK: - Core Data

    public var persistentContainer: NSPersistentContainer = {
        if UserDefaults.standard.bool(forKey: "SettingsStore.cloudKitEnabled") {
            let modelURL = Bundle.main.url(forResource: "___PACKAGENAMEASIDENTIFIER___", withExtension: "momd")!
            let model = NSManagedObjectModel(contentsOf: modelURL)!
            let container = NSPersistentCloudKitContainer(name: "___PACKAGENAMEASIDENTIFIER___", managedObjectModel: model)
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.loadPersistentStores(completionHandler: { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        } else {
            let modelURL = Bundle.main.url(forResource: "___PACKAGENAMEASIDENTIFIER___", withExtension: "momd")!
            let model = NSManagedObjectModel(contentsOf: modelURL)!
            let container = NSPersistentContainer(name: "___PACKAGENAMEASIDENTIFIER___", managedObjectModel: model)
            container.loadPersistentStores(completionHandler: { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func save() async throws {
        try await context.perform {
            do {
                try self.context.save()
            } catch {
                throw AppError.coreData(type: .savingItem)
            }
        }
    }

    public func deleteAll(_ objectType: (some NSManagedObject).Type) async throws {
        let deleteRequest: NSBatchDeleteRequest = .init(fetchRequest: objectType.fetchRequest())
        do { try context.execute(deleteRequest) }
        catch { throw AppError.coreData(type: .deleteItem) }
        try await save()
    }
}
