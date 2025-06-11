//
//  ItemSchemaV2.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import SwiftData

class ItemMigrationSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    @Model
    final class Item {
        var attr1: String
        var attr2: String?
        
        init(attr1: String) {
            self.attr1 = attr1
            self.attr2 = "Created"
        }
        
        init(migratedAttr1: String) {
            self.attr1 = migratedAttr1
            self.attr2 = "Migrated"
        }
    }
    
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
}