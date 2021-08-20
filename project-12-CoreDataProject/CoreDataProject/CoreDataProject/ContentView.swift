//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc

  var body: some View {
    Button("Save") {
      if moc.hasChanges {
        try? moc.save()
      }
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
