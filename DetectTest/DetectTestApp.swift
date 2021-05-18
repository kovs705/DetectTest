//
//  DetectTestApp.swift
//  DetectTest
//
//  Created by Kovs on 18.05.2021.
//

import SwiftUI

@main
struct DetectTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
