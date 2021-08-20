//
//  ConstraintExampleView.swift
//  ConstraintExampleView
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI

struct ConstraintExampleView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

  var body: some View {
    VStack {
      List(wizards, id: \.self) { wizard in
        Text(wizard.name ?? "Unknown")
      }

      Button("Add") {
        let wizard = Wizard(context: moc)
        wizard.name = "Harry Potter"
      }

      Button("Save") {
        do {
          try moc.save()
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    .navigationTitle("Constraints")
  }
}

struct ConstraintExampleView_Previews: PreviewProvider {
  static var previews: some View {
    ConstraintExampleView()
  }
}
