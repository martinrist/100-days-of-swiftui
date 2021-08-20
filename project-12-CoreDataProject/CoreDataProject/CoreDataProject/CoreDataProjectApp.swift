//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Martin Rist on 20/08/2021.
//

import CoreData
import SwiftUI

@main
struct CoreDataProjectApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    let managedObjectContext = persistenceController.container.viewContext
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

    return WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, managedObjectContext)
    }
  }
}
