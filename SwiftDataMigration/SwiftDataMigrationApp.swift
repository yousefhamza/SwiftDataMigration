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
    static var schemas: [any VersionedSchema.Type] = []
    
    static var stages: [MigrationStage] = []
}

class ItemMigrationSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
}
