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

  var body: some View {
    List {
      ForEach(astronauts) { astronaut in
        Text(astronaut.name)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
