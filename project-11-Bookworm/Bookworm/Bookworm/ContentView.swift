//
//  ContentView.swift
//  Bookworm
//
//  Created by Martin Rist on 18/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>

  @State private var showingAddScreen = false

  var body: some View {
    NavigationView {
      Text("Count: \(books.count)")
        .navigationBarTitle("Bookworm")
        .navigationBarItems(trailing: Button(action: {
          self.showingAddScreen.toggle()
        }) {
          Image(systemName: "plus")
        })
        .sheet(isPresented: $showingAddScreen) {
          AddBookView().environment(\.managedObjectContext, moc)
        }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
