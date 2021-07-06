//
//  AstronautView.swift
//  Moonshot
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  let flownMissions: [Mission]

  init(astronaut: Astronaut, allMissions: [Mission]) {
    self.astronaut = astronaut
    self.flownMissions = allMissions.filter { $0.crew.contains(where: { $0.name == astronaut.id })}
  }

  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Image(astronaut.id)
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width)

          Text(astronaut.description)
            .padding()
        }

        VStack(alignment: .leading) {
          ForEach(flownMissions) { mission in
            HStack {
              Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)

              VStack(alignment: .leading) {
                Text(mission.displayName)
                  .font(.headline)
                Text(mission.formattedLaunchDate)
              }
              Spacer()
            }
          }
        }
        .padding()
      }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static let missions: [Mission] = Bundle.main.decode("missions.json")

  static var previews: some View {
    AstronautView(astronaut: astronauts[0], allMissions: missions)
  }
}
