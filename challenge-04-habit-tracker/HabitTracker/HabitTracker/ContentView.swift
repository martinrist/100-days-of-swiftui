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
        ForEach(modelData.actitivies) { activity in
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

struct ContentView_Previews: PreviewProvider {

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(modelData: ModelData.testData)
  }
}
