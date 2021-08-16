//
//  CheckoutView.swift
//  CheckoutView
//
//  Created by Martin Rist on 16/08/2021.
//

import SwiftUI

struct CheckoutView: View {

  @ObservedObject var order: Order

  var body: some View {
    GeometryReader { reader in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: reader.size.width)

          Text("Your total is $\(order.cost, specifier: "%.2f")")
            .font(.title)

          Button("Place order") {
            // place order
          }
          .padding()
        }
      }
    }
    .navigationBarTitle("Check out", displayMode: .inline)
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
