//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Martin Rist on 31/08/2021.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    NavigationView {
      List {
        NavigationLink(destination: AccessibilityLabelExampleView()) {
          Text("Accessibility Label example")
        }
      }
      .navigationTitle("Accessibility")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
