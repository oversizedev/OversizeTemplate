//
// Copyright © ___DATE___ ___FULLUSERNAME___
// ___FILEBASENAMEASIDENTIFIER___
//

import CoreData
import Foundation

public extension ___VARIABLE_CoreDataModelName___ {
    @nonobjc class func fetchRequest() -> NSFetchRequest<___VARIABLE_CoreDataModelName___> {
        NSFetchRequest<___VARIABLE_CoreDataModelName___>(entityName: "___VARIABLE_CoreDataModelName___")
    }

    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var date: Date?
}

extension ___VARIABLE_CoreDataModelName___: Identifiable {}

public extension ___VARIABLE_CoreDataModelName___ {
    static var all: NSFetchRequest<___VARIABLE_CoreDataModelName___> {
        let request = ___VARIABLE_CoreDataModelName___.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return request
    }
}

@objc(___VARIABLE_CoreDataModelName___)
public class ___VARIABLE_CoreDataModelName___: NSManagedObject {}
