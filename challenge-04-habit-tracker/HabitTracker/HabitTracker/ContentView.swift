//
//  ContentView.swift
//  HabitTracker
//
//  Created by Martin Rist on 18/07/2021.
//

import SwiftUI

struct ContentView: View {

  @ObservedObject var modelData: ModelData
  @State private var showingAddSheet = false

  var body: some View {
    NavigationView {
      List {
        ForEach(modelData.activities) { activity in
          ActivityRowView(activity: activity)
        }
        .onDelete(perform: deleteActivities)
      }
      .navigationBarTitle("Habit Tracker")
      .navigationBarItems(leading: EditButton(),
                          trailing: Button(action: { showingAddSheet = true }) {
        Image(systemName: "plus")
      })
    }
    .sheet(isPresented: $showingAddSheet) {
      AddActivityView(modelData: modelData)
    }
  }

  func deleteActivities(offsets: IndexSet) {
    modelData.activities.remove(atOffsets: offsets)
  }
}

struct ActivityRowView: View {

  @ObservedObject var activity: Activity

  var body: some View {
    NavigationLink(destination: ActivityDetailView(activity: activity)) {
      HStack {
        VStack(alignment: .leading) {
          Text("\(activity.title)")
          Text("\(activity.description)").font(.caption)
        }
        Spacer()
        Text("\(activity.timesCompleted)")
      }
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(modelData: ModelData.testData)
  }
}
