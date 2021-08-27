//
//  AddActivityView.swift
//  AddActivityView
//
//  Created by Martin Rist on 18/07/2021.
//

import SwiftUI

struct AddActivityView: View {

  @Environment(\.presentationMode) var presentationMode

  @ObservedObject var modelData: ModelData
  @State private var title = ""
  @State private var description = ""

  var formValid: Bool {
    !title.isEmpty && !description.isEmpty
  }

  var body: some View {
    NavigationView {
      Form {
        TextField("Title", text: $title)
        TextField("Description", text: $description)
      }
      .navigationBarTitle("Add Activity")
      .navigationBarItems(
        leading: Button("Cancel", action: { presentationMode.wrappedValue.dismiss() }),
        trailing: Button("Save", action: saveActivity).disabled(!formValid)
      )
    }
  }

  func saveActivity() {
    let activity = Activity(title: title, description: description)
    modelData.activities.append(activity)
    presentationMode.wrappedValue.dismiss()
  }
}

struct AddActivityView_Previews: PreviewProvider {
  static var previews: some View {
    AddActivityView(modelData: ModelData())
  }
}
