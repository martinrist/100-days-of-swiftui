//
//  AstronautView.swift
//  Moonshot
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut

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
      }
    }
    .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

  static var previews: some View {
    AstronautView(astronaut: astronauts[0])
  }
}
