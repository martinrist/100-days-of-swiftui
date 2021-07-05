//
//  ContentView.swift
//  iExpense
//
//  Created by Martin Rist on 05/07/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Int
}

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem]() {
    didSet {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: "Items")
      }
    }
  }

  init() {
    if let items = UserDefaults.standard.data(forKey: "Items") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
        self.items = decoded
      }
    }
  }
}

struct AmountColour: ViewModifier {
  let amount: Int

  func body(content: Content) -> some View {
    if amount < 10 {
      return content.foregroundColor(.gray)
    } else if amount < 100 {
      return content.foregroundColor(.blue)
    } else {
      return content.foregroundColor(.red)
    }
  }
}

struct ContentView: View {
  @ObservedObject var expenses = Expenses()
  @State private var showingAddExpense = false

  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          HStack {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              Text(item.type)
            }
            Spacer()
            Text("$\(item.amount)")
              .modifier(AmountColour(amount: item.amount))
          }
        }
        .onDelete(perform: removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(leading: EditButton(),
                          trailing:
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
