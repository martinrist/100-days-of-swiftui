//
//  ConditionalSavingExampleView.swift
//  ConditionalSavingExampleView
//
//  Created by Martin Rist on 20/08/2021.
//

import SwiftUI

struct ConditionalSavingExampleView: View {
  @Environment(\.managedObjectContext) var moc

  var body: some View {
    Button("Save") {
      if moc.hasChanges {
        try? moc.save()
      }
    }
    .navigationTitle("Conditional Saving")
  }
}

struct ConditionalSavingExampleView_Previews: PreviewProvider {
  static var previews: some View {
    ConditionalSavingExampleView()
  }
}
