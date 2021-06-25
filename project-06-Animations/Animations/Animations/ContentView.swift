//
//  ContentView.swift
//  Animations
//
//  Created by Martin Rist on 25/06/2021.
//

import SwiftUI

struct ContentView: View {
  @State private var animationAmount: CGFloat = 1

  var body: some View {
    Button("Tap Me") {
      animationAmount += 1
    }
    .padding(50)
    .background(Color.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount)
    .blur(radius: (animationAmount - 1) * 3)
    .animation(.default)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
