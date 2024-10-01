//
//  swift_dataApp.swift
//  swift-data
//
//  Created by Usman N on 01/10/2024.
//

import SwiftUI
import SwiftData

@main
struct swift_dataApp: App {
    
    // 2 Define Container containing the persisted types
    let container: ModelContainer = {
        let container = try! ModelContainer(for: Schema([Student.self]), configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // 3 Attach container to the app
        .modelContainer(container)
    }
}
