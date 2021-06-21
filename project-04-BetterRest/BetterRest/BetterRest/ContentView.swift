//
//  ContentView.swift
//  BetterRest
//
//  Created by Martin Rist on 21/06/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var wakeUp = Date()

  var body: some View {
    DatePicker("Please enter a date",
               selection: $wakeUp,
               in: Date()...,
               displayedComponents: .hourAndMinute)
      .labelsHidden()
      .datePickerStyle(.wheel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
