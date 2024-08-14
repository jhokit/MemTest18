//
//  MyImage+CoreDataProperties.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/14/24.
//
//

import Foundation
import CoreData


extension MyImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyImage> {
        return NSFetchRequest<MyImage>(entityName: "MyImage")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var item: CoreItem?

}

extension MyImage : Identifiable {

}
