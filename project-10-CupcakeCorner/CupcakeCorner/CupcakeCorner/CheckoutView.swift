//
//  CheckoutView.swift
//  CheckoutView
//
//  Created by Martin Rist on 16/08/2021.
//

import SwiftUI

struct CheckoutView: View {

  @ObservedObject var model: Model

  @State private var confirmationMessage = ""
  @State private var showingConfirmation = false

  @State private var errorMessage = ""
  @State private var showingError = false

  var body: some View {
    GeometryReader { reader in
      ScrollView {
        VStack {
          Image(decorative: "cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: reader.size.width)

          Text("Your total is $\(model.order.cost, specifier: "%.2f")")
            .font(.title)
            .alert(isPresented: $showingError) {
              Alert(title: Text("Sorry"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }

          Button("Place order", action: placeOrder)
            .padding()
            .alert(isPresented: $showingConfirmation) {
              Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
      }
    }
    .navigationBarTitle("Check out", displayMode: .inline)
  }

  func placeOrder() {
    guard let encoded = try? JSONEncoder().encode(model.order) else {
      errorMessage = "Failed to encode order"
      showingError = true
      return
    }

    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded

    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        errorMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
        showingError = true
        return
      }

      if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
        confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        showingConfirmation = true
      } else {
        errorMessage = "Invalid response from server"
        showingError = true
      }

    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(model: Model())
  }
}
