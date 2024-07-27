//
//  Item.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
