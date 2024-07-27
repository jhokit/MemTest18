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
    var timestamp: Date?
    @Attribute(.externalStorage) var image:Data?   // jpeg image data
    @Attribute(.externalStorage) var thumbnail:Data? // jpeg thumbnail data
    var folder:Folder?  // the Folder that this record belongs to

    init(timestamp: Date, image: UIImage) {
        self.timestamp = timestamp
        self.image = image.jpegData(compressionQuality: 1.0)
        self.thumbnail = image.preparingThumbnail(of: CGSize(width: 500, height: 500))?.jpegData(compressionQuality: 1.0)
    }
}
