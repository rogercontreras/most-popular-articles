//
//  Most_Popular_ArticlesApp.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 04/12/24.
//

import SwiftUI
import SwiftData

@main
struct Most_Popular_ArticlesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
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
