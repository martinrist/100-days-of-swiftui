//
//  AddActivityView.swift
//  AddActivityView
//
//  Created by Martin Rist on 18/07/2021.
//

import SwiftUI

struct AddActivityView: View {

  @Environment(\.presentationMode) var presentationMode

  @ObservedObject var activities: ModelData
  @State private var title = ""
  @State private var description = ""

  var body: some View {
    NavigationView {
      Form {
        TextField("Title", text: $title)
        TextField("Description", text: $description)
      }
      .navigationBarTitle("Add Activity")
      .navigationBarItems(trailing: Button("Save") {
        let activity = Activity(title: title, description: description)
        activities.actitivies.append(activity)
        presentationMode.wrappedValue.dismiss()
      })
    }
  }
}

struct AddActivityView_Previews: PreviewProvider {
  static var previews: some View {
    AddActivityView(activities: ModelData())
  }
}
