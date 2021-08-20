//
//  DynamicFilteringExampleView.swift
//  DynamicFilteringExampleView
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI

struct DynamicFilteringExampleView: View {

  @Environment(\.managedObjectContext) var moc
  @State private var lastNameFilter = "A"

  var body: some View {
    VStack {
      FilteredList(filter: lastNameFilter)

      Button("Add Examples") {
        let taylor = Singer(context: moc)
        taylor.firstName = "Taylor"
        taylor.lastName = "Swift"

        let ed = Singer(context: moc)
        ed.firstName = "Ed"
        ed.lastName = "Sheeran"

        let adele = Singer(context: moc)
        adele.firstName = "Adele"
        adele.lastName = "Adkins"

        try? moc.save()
      }

      Button("Show A") {
        lastNameFilter = "A"
      }

      Button("Show S") {
        lastNameFilter = "S"
      }

    }
    .navigationTitle("Dynamic Filtering")
  }
}

struct DynamicFilteringExampleView_Previews: PreviewProvider {
  static var previews: some View {
    DynamicFilteringExampleView()
  }
}
