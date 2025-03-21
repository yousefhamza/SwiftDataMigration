//
//  Item.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import Foundation
import SwiftData

@Model
final class ItemV1 {
    var attr1: String
    
    init(attr1: String) {
        self.attr1 = attr1
    }
}


@Model
final class Item {
    var attr1: String
    var attr2: String
    
    init(attr1: String) {
        self.attr1 = attr1
        self.attr2 = "Created"
    }
    
    init(previous: ItemV1) {
        self.attr1 = previous.attr1
        self.attr2 = "Migrated"
    }
}
