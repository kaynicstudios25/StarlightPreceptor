//
//  MyFirstProjectApp.swift
//  MyFirstProject
//
//  Created by Kaylyn Groom on 2/3/26.
//

import SwiftUI
import SwiftData

@main
struct StarlightPreceptorApp: App {
    
    let container: ModelContainer = {
        let schema = Schema([Hours.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
            .modelContainer(for: Hours.self)
    }
}
