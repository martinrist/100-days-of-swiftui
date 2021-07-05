//
//  AddView.swift
//  iExpense
//
//  Created by Martin Rist on 05/07/2021.
//

import SwiftUI

struct AddView: View {

  @ObservedObject var expenses: Expenses

  @Environment(\.presentationMode) var presentationMode

  @State private var name = ""
  @State private var type = "Business"
  @State private var amount = ""
  @State private var showingErrorAlert = false

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
      .navigationBarItems(trailing: Button("Save") {
        guard let actualAmount = Int(amount) else {
          showingErrorAlert = true
          return
        }

        let item = ExpenseItem(name: name, type: type, amount: actualAmount)
        expenses.items.append(item)
        presentationMode.wrappedValue.dismiss()
      })
    }
    .alert(isPresented: $showingErrorAlert) {
      Alert(title: Text("Error"),
            message: Text("Please enter a valid amount"),
            dismissButton: .default(Text("Ok"), action: { amount = "" }))
    }
  }
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView(expenses: Expenses())
  }
}
