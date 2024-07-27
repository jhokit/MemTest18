//
//  Folder.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import Foundation
import SwiftData

@Model final class Folder {
    
    var name:String = "Untitled"
    @Transient var iconName:String = "folder"
    
    // array of Items
    @Relationship(deleteRule: .nullify, inverse: \Item.folder) var items: [Item]?
    
    init(name:String) {
        self.name = name
    }

}
