//
//  Item.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var attr1: String
    
    init(attr1: String) {
        self.attr1 = attr1
    }
}
