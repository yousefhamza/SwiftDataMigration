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
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
