//
//  ContentView.swift
//  Instafilter
//
//  Created by Martin Rist on 24/08/2021.
//

import SwiftUI

struct ContentView: View {
  @State private var showingActionSheet = false
  @State private var backgroundColour = Color.white

  var body: some View {
    Text("Hello, world!")
      .frame(width: 300, height: 300)
      .background(backgroundColour)
      .onTapGesture {
        showingActionSheet = true
      }
      .actionSheet(isPresented: $showingActionSheet) {
        ActionSheet(title: Text("Change background"),
                    message: Text("Select a new colour"),
                    buttons: [
                      .default(Text("Red")) { backgroundColour = .red },
                      .default(Text("Green")) { backgroundColour = .green },
                      .default(Text("Blue")) { backgroundColour = .blue },
                      .cancel()
                    ])
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
