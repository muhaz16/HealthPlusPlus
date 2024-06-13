//
//  HealthPlusPlusApp.swift
//  HealthPlusPlus
//
//  Created by Lucas Bui on 15/8/2023.
//

import SwiftUI

@main
struct HealthPlusPlusApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
