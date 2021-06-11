//
//  ContentView.swift
//  WeSplit
//
//  Created by Martin Rist on 11/06/2021.
//

import SwiftUI

struct ContentView: View {

  @State private var checkAmount = ""
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2

  let tipPercentages = [10, 15, 20, 25, 0]

  var grandTotal: Double {
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0

    let tipValue = orderAmount / 100 * tipSelection
    return orderAmount + tipValue
  }

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople) ?? 1
    return grandTotal / peopleCount
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)

          TextField("Number of people", text: $numberOfPeople)
            .keyboardType(.numberPad)
        }

        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<tipPercentages.count) {
              Text("\(tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Total amount")) {
          Text("$\(grandTotal, specifier: "%.2f")")
        }

        Section(header: Text("Amount per person")) {
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
