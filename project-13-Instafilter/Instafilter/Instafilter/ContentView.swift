//
//  ContentView.swift
//  Instafilter
//
//  Created by Martin Rist on 24/08/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var blurAmount: CGFloat = 0

  var body: some View {
    let blur = Binding<CGFloat>(
      get: {
        self.blurAmount
      }, set: {
        self.blurAmount = $0
        print("New value is \(blurAmount)")
      }
    )

    return VStack {
      Text("Hello, world!")
        .blur(radius: blurAmount)

      Slider(value: blur, in: 0...20)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
