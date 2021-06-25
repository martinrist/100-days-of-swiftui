//
//  ContentView.swift
//  Animations
//
//  Created by Martin Rist on 25/06/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var animationAmount = 0.0

  var body: some View {
    Button("Tap me") {
      withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
        animationAmount += 360
      }
    }
    .padding(50)
    .background(Color.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .rotation3DEffect(.degrees(animationAmount),
                      axis: (x: 1, y: 1, z: 0))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
