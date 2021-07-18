//
//  ContentView.swift
//  HabitTracker
//
//  Created by Martin Rist on 18/07/2021.
//

import SwiftUI

struct ContentView: View {

  @ObservedObject var activities: ModelData
  @State private var showingAddSheet = false

  var body: some View {
    NavigationView {
      List {
        ForEach(activities.actitivies) { activity in
          Text("\(activity.title)")
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
      AddActivityView(activities: activities)
    }
  }

  func deleteActivities(offsets: IndexSet) {
    activities.actitivies.remove(atOffsets: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(activities: ModelData())
  }
}
