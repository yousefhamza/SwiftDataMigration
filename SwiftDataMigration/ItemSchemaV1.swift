//
//  ItemSchemaV1.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import SwiftData

class ItemMigrationSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    @Model
    final class Item {
        var attr1: String
        
        init(attr1: String) {
            self.attr1 = attr1
        }
    }

    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
}