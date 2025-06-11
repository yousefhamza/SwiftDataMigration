//
//  ItemMigrationPlan.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import SwiftData

class ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [ItemMigrationSchemaV1.self, ItemMigrationSchemaV2.self]
    
    static var stages: [MigrationStage] = [migrateV1ToV2]
    
    static var migrateV1ToV2: MigrationStage = {
        return MigrationStage.custom(
            fromVersion: ItemMigrationSchemaV1.self,
            toVersion: ItemMigrationSchemaV2.self,
            willMigrate: { context in
                // Pre-migration logic if needed
            },
            didMigrate: { context in
                do {
                    let items = try context.fetch(FetchDescriptor<ItemMigrationSchemaV2.Item>())
                    for item in items {
                        item.attr2 = "migrated"
                    }
                    try context.save()
                } catch {
                    print("Migration error: \(error)")
                    throw error
                }
            }
        )
    }()
}