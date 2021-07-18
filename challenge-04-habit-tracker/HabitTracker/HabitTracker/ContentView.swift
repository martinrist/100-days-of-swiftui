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
    modelData.actitivies.remove(atOffsets: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {

  static var modelData: ModelData = {
    var modelData = ModelData()
    modelData.actitivies = [Activity(title: "Title 1", description: "Description 1", timesCompleted: 5),
                            Activity(title: "Title 2", description: "Description 2", timesCompleted: 4),
                            Activity(title: "Title 3", description: "Description 3", timesCompleted: 2),
                            Activity(title: "Title 4", description: "Description 4", timesCompleted: 0)
                            ]
    return modelData
  }()

  static var previews: some View {
    ContentView(modelData: modelData)
  }
}
