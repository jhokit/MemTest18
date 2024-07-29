//
//  Folder.swift
//  MemTest18
//
//  Created by Jeff Hokit on 7/27/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model final class Folder {

    public var uuid:String = UUID().uuidString // handy uuID
    var name:String = "Untitled"

    // array of Items
    @Relationship(deleteRule: .nullify, inverse: \Item.folder) var items: [Item]?
    
    init(name:String) {
        self.name = name
    }


}

