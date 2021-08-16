//
//  Order.swift
//  Order
//
//  Created by Martin Rist on 16/08/2021.
//

import Foundation

class Order: ObservableObject {
  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

  @Published var type = 0
  @Published var quantity = 3
  
  @Published var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  @Published var extraFrosting = false
  @Published var addSprinkles = false
}
