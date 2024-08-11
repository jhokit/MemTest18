//
//  CoreFolder+CoreDataProperties.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/11/24.
//
//

import Foundation
import CoreData


extension CoreFolder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreFolder> {
        return NSFetchRequest<CoreFolder>(entityName: "Folder")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension CoreFolder {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CoreItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CoreItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension CoreFolder : Identifiable {

}
