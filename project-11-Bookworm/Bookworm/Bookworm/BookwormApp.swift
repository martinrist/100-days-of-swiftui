//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Martin Rist on 18/08/2021.
//

import SwiftUI

@main
struct BookwormApp: App {
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
