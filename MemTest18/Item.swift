//
//  Item.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Item {
    var uuid:String = UUID().uuidString // handy uuID
    var timestamp: Date?
    @Relationship(deleteRule:.cascade) var image:ItemImage?   // jpeg image data
    @Relationship(deleteRule:.cascade) var thumbnail:ItemImage?   // jpeg thumbnail data
    var folder:Folder?  // the Folder that this record belongs to

    init(timestamp: Date, image: UIImage) {
        self.timestamp = timestamp
        
        let imageData = image.jpegData(compressionQuality: 1.0)!
        self.image = ItemImage(imageData: imageData)
        
        let thumbnailData = image.preparingThumbnail(of: CGSize(width: 500, height: 500))!.jpegData(compressionQuality: 1.0)!
        
        self.thumbnail = ItemImage(imageData:thumbnailData)
    }
}
