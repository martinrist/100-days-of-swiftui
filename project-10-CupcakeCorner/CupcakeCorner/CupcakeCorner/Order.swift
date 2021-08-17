//
//  Order.swift
//  Order
//
//  Created by Martin Rist on 16/08/2021.
//

import Foundation

class Model: ObservableObject {
  @Published var order: Order

  init() {
    order = Order()
  }
}

struct Order: Codable {

  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

  var type = 0
  var quantity = 3
  
  var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  var extraFrosting = false
  var addSprinkles = false

  var name = ""
  var streetAddress = ""
  var city = ""
  var zip = ""

  var hasValidAddress: Bool {
    if name.isEmptyOrWhitespace()
        || streetAddress.isEmptyOrWhitespace()
        || city.isEmptyOrWhitespace()
        || zip.isEmptyOrWhitespace() {
      return false
    } else {
      return true
    }
  }

  var cost: Double {

    var cost = Double(quantity) * 2
    cost += Double(type) / 2
    if extraFrosting {
      cost += Double(quantity)
    }
    if addSprinkles {
      cost += Double(quantity) / 2
    }

    return cost
  }
}
