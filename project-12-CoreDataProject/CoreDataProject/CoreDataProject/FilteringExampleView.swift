//
//  FilteringExampleView.swift
//  FilteringExampleView
//
//  Created by Martin Rist on 20/08/2021.
//

import CoreData
import SwiftUI

struct FilteringExampleView: View {

  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Ship.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>

  var body: some View {
    VStack {
      List(ships, id: \.self) { ship in
        Text(ship.name ?? "Unknown name")
      }

      Button("Add exmmples") {
        let ship1 = Ship(context: moc)
        ship1.name = "Enterprise"
        ship1.universe = "Star Trek"

        let ship2 = Ship(context: moc)
        ship2.name = "Defiant"
        ship2.universe = "Star Trek"

        let ship3 = Ship(context: moc)
        ship3.name = "Millenium Falcon"
        ship3.universe = "Star Wars"

        let ship4 = Ship(context: moc)
        ship4.name = "Executor"
        ship4.universe = "Star Wars"

        try? moc.save()
      }
    }
    .navigationTitle("Filtering")
  }
}

struct FilteringExampleView_Previews: PreviewProvider {
  static var previews: some View {
    FilteringExampleView()
  }
}
