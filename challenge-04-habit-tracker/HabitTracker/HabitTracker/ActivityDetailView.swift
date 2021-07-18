//
//  ActivityDetailView.swift
//  ActivityDetailView
//
//  Created by Martin Rist on 18/07/2021.
//

import SwiftUI

struct ActivityDetailView: View {

  @ObservedObject var activity: Activity

  var body: some View {
    Form {
      Text(activity.title)
      Text(activity.description)
      Text("Completed \(activity.timesCompleted) times")
      Button("Complete Activity") {
        activity.timesCompleted += 1
      }
      .navigationBarTitle("Activity Detail")
    }
  }
}

struct ActivityDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityDetailView(activity: ModelData.testData.activities[0])
  }
}
