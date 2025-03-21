//
//  SwiftDataMigrationApp.swift
//  SwiftDataMigration
//
//  Created by Yosef Hamza on 21/03/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataMigrationApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, migrationPlan: ItemMigrationPlan.self, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

class ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] = [ItemMigrationSchemaV1.self, ItemMigrationSchemaV2.self]
    
    static var stages: [MigrationStage] = [migrateV1ToV2]
    
    static var migrateV1ToV2 = MigrationStage.custom(fromVersion: ItemMigrationSchemaV1.self,
                                                     toVersion: ItemMigrationSchemaV2.self,
                                                     willMigrate: { context in
        print("Will run migration")
        let items = try! context.fetch(FetchDescriptor<ItemMigrationSchemaV1.Item>())
        print("Will run migration on \(items.count) items")
        for item in items {
            context.insert(Item(previous: item))
            context.delete(item)
        }
        try! context.save()
        print("Did run migration")
    }, didMigrate: nil)
}

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

class ItemMigrationSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    @Model
    final class Item {
        var attr1: String
        var attr2: String
        
        init(attr1: String) {
            self.attr1 = attr1
            self.attr2 = "Created"
        }
        
        init(previous: ItemMigrationSchemaV1.Item) {
            self.attr1 = previous.attr1
            self.attr2 = "Migrated"
        }
    }
    
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
}
