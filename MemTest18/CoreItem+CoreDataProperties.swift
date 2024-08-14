//
//  CoreItem+CoreDataProperties.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/14/24.
//
//

import Foundation
import CoreData


extension CoreItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreItem> {
        return NSFetchRequest<CoreItem>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var uuid: String?
    @NSManaged public var folder: CoreFolder?
    @NSManaged public var image: MyImage?
    @NSManaged public var thumbnail: MyThumbnail?

}

extension CoreItem : Identifiable {

}
