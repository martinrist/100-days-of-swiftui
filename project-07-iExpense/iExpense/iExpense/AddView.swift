//
//  AddView.swift
//  iExpense
//
//  Created by Martin Rist on 05/07/2021.
//

import SwiftUI

struct AddView: View {

  @ObservedObject var expenses: Expenses

  @State private var name = ""
  @State private var type = "Business"
  @State private var amount = ""

  static let types = ["Business", "Personal"]


  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)

        Picker("Type", selection: $type) {
          ForEach(Self.types, id: \.self) {
            Text($0)
          }
        }
        .pickerStyle(.segmented)

        TextField("Amount", text: $amount)
          .keyboardType(.numberPad)
      }
      .navigationBarTitle("Add new expense")
    }
  }
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView(expenses: Expenses())
  }
}
