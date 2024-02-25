//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import CoreData
import Foundation

public class PersistenceController {
    public static let shared: PersistenceController = .init()

    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate

    public var context: NSManagedObjectContext { persistentContainer.viewContext }

    // MARK: - Core Data

    public init(inMemory _: Bool = false) {
        let modelURL = Bundle.main.url(forResource: "___PACKAGENAMEASIDENTIFIER___", withExtension: "momd")!
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("\(#function): Not NSManagedObjectModel file")
        }
        let container = NSPersistentCloudKitContainer(name: "___PACKAGENAMEASIDENTIFIER___", managedObjectModel: model)

        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("\(#function): Failed to retrieve a persistent store description.")
        }

        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

        description.setOption(true as NSNumber,
                              forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        // if "icloud_sync" boolean key isn't set or isn't set to true, don't sync to iCloud
        if !UserDefaults.standard.bool(forKey: "SettingsStore.cloudKitEnabled") {
            description.cloudKitContainerOptions = nil
        }

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        persistentContainer = container
    }

    public var persistentContainer: NSPersistentContainer

    public func saveContext() {
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
