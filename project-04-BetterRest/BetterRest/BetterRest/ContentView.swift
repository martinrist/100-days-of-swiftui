//
//  ContentView.swift
//  BetterRest
//
//  Created by Martin Rist on 21/06/2021.
//

import SwiftUI

struct ContentView: View {
  
  @State private var wakeUp = Date()
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  var body: some View {
    NavigationView {
      VStack {
        Text("When do you want to wake up?")
          .font(.headline)
        
        DatePicker("Please enter a time",
                   selection: $wakeUp,
                   displayedComponents: .hourAndMinute)
          .datePickerStyle(WheelDatePickerStyle())
          .labelsHidden()
        
        Text("Desired abount of sleep")
          .font(.headline)
        
        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
          Text("\(sleepAmount, specifier: "%g") hours")
        }
        
        Text("Daily coffee intake")
          .font(.headline)
        
        Stepper(value: $coffeeAmount, in: 1...20) {
          Text("\(coffeeAmount) cup\(coffeeAmount > 1 ? "s" : "")")
        }
      }
      .padding()
      .navigationTitle("BetterRest")
      .navigationBarItems(trailing: Button(action: calculateBedtime) {
        Text("Calculate")
      })
    }
  }
  
  func calculateBedtime() {
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
