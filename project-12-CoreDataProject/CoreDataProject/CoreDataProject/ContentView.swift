//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: ConditionalSavingExampleView()) {
          Text("Conditional Saving")
        }
        NavigationLink(destination: ConstraintExampleView()) {
          Text("Constraints")
        }
        NavigationLink(destination: FilteringExampleView()) {
          Text("Filtering with `NSPredicate`")
        }
        NavigationLink(destination: DynamicFilteringExampleView()) {
          Text("Dynamic Filtering")
        }
        NavigationLink(destination: OneToManyExampleView()) {
          Text("One to Many Relationships")
        }
      }
      .navigationTitle("Core Data Examples")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
