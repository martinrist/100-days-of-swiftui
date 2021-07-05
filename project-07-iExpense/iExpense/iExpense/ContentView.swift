//
//  ContentView.swift
//  iExpense
//
//  Created by Martin Rist on 05/07/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem]()
}

struct ContentView: View {
  @ObservedObject var expenses = Expenses()
  @State private var showingAddExpense = false

  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          Text(item.name)
        }
        .onDelete(perform: removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(trailing:
                            Button(action: {
        showingAddExpense = true
      }) {
        Image(systemName: "plus")
      }
      )
    }
    .sheet(isPresented: $showingAddExpense) {
      AddView(expenses: expenses)
    }
  }

  func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
