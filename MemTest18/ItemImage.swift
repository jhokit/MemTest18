//
//  ItemImage.swift
//  MemTest18
//
//  Created by Jeff Hokit on 8/8/24.
//


import Foundation
import SwiftData
import UIKit

@Model
final class ItemImage {
    @Attribute(.externalStorage) var imageData:Data?   // jpeg image data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}

