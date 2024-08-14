//
//  MyThumbnail+CoreDataProperties.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/14/24.
//
//

import Foundation
import CoreData


extension MyThumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyThumbnail> {
        return NSFetchRequest<MyThumbnail>(entityName: "MyThumbnail")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var item: CoreItem?

}

extension MyThumbnail : Identifiable {

}
