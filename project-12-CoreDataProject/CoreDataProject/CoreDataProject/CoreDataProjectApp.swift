//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
