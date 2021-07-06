//
//  ContentView.swift
//  Moonshot
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct ContentView: View {
  let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")

  @State private var showingLaunchDates = true

  var body: some View {
    NavigationView {
      List(missions) { mission in
        NavigationLink(destination: MissionView(mission: mission,
                                                allMissions: missions,
                                                astronauts: astronauts)) {
          Image(mission.image)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)

          VStack(alignment: .leading) {
            Text(mission.displayName)
              .font(.headline)
            showingLaunchDates ? Text(mission.formattedLaunchDate) : Text(crewList(for: mission))
          }
        }
      }
      .navigationBarTitle("Moonshot")
      .navigationBarItems(trailing: Button(showingLaunchDates ? "Crew" : "Launch Dates") {
        showingLaunchDates.toggle()
      })
    }
  }

  func crewList(for mission: Mission) -> String {
    let crewIds = mission.crew.map(\.name)
    let astronautsForMission = crewIds.compactMap { crewId in
      astronauts.first { $0.id == crewId }
    }
    return astronautsForMission.map(\.name).joined(separator: "\n")
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
