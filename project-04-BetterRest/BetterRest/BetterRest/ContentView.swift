//
//  ContentView.swift
//  BetterRest
//
//  Created by Martin Rist on 21/06/2021.
//

import SwiftUI

struct ContentView: View {

  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
  }

  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1

  var body: some View {
    NavigationView {
      Form {

        Section(header: Text("When do you want to wake up?")) {
          DatePicker("Please enter a time",
                     selection: $wakeUp,
                     displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }

        Section(header: Text("Desired amount of sleep")) {
          Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
          }
          .accessibilityValue(sleepAmount == 1 ? "1 hour" : "\(sleepAmount, specifier: "%g") hours")
        }

        Section(header: Text("Daily coffee intake")) {
          Stepper(value: $coffeeAmount, in: 1...20) {
            Text("\(coffeeAmount) cup\(coffeeAmount > 1 ? "s" : "")")
          }
          .accessibilityValue("\(coffeeAmount) cup\(coffeeAmount > 1 ? "s" : "")")
        }

        Section(header: Text("Recommended bedtime")) {
          Text(calculateBedtime())
            .font(.headline)
        }
      }
      .navigationTitle("BetterRest")
    }
  }

  func calculateBedtime() -> String {
    let model = SleepCalculator()

    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    let hour = (components.hour ?? 0) * 60 * 60
    let minute = (components.minute ?? 0) * 60

    do {
      let prediction = try model.prediction(wake: Double(hour + minute),
                                            estimatedSleep: sleepAmount,
                                            coffee: Double(coffeeAmount))
      let sleepTime = wakeUp - prediction.actualSleep

      let formatter = DateFormatter()
      formatter.timeStyle = .short
      return formatter.string(from: sleepTime)

    } catch {
      return "Sorry, there was a problem calculating your bedtime"
    }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
