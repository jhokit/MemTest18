//
//  CoreItem+CoreDataProperties.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/11/24.
//
//

import Foundation
import CoreData


extension CoreItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreItem> {
        return NSFetchRequest<CoreItem>(entityName: "Item")
    }

    @NSManaged public var uuid: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var image: Data?
    @NSManaged public var thumbnail: Data?
    @NSManaged public var folder: CoreFolder?

}

extension CoreItem : Identifiable {

}
