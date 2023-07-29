//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import CoreData
import Foundation
import OversizeServices

class PersistenceController {
    static let shared: PersistenceController = .init()

    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    // MARK: - Core Data

    init(inMemory: Bool = false) {
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
            persistentContainer = container
        } else {
            let modelURL = Bundle.main.url(forResource: "___PACKAGENAMEASIDENTIFIER___", withExtension: "momd")!
            let model = NSManagedObjectModel(contentsOf: modelURL)!
            let container = NSPersistentContainer(name: "___PACKAGENAMEASIDENTIFIER___", managedObjectModel: model)
            container.loadPersistentStores(completionHandler: { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            persistentContainer = container
        }
    }

    var persistentContainer: NSPersistentContainer

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
}

extension PersistenceController {
    func create(_: NSManagedObject) {
        saveContext()
    }

    func read<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }

    func readFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1

        do {
            let result = try context.fetch(request)
            return .success(result.first as? T)
        } catch {
            return .failure(error)
        }
    }

    func update(_: some NSManagedObject) {
        saveContext()
    }

    func delete(_ object: some NSManagedObject) {
        context.delete(object)
        saveContext()
    }
}
