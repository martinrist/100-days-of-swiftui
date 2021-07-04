//
//  ContentView.swift
//  TableTester
//
//  Created by Martin Rist on 04/07/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var settingUp = true
  @State private var questions: [Question] = []

  var body: some View {
    NavigationView {
      if settingUp {
        SetupView(settingUp: $settingUp, questions: $questions)
      } else {
        GameView(settingUp: $settingUp, questions: questions)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
