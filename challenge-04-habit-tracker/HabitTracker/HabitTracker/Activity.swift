//
//  Activity.swift
//  Activity
//
//  Created by Martin Rist on 18/07/2021.
//

import Foundation
import Combine

struct Activity: Identifiable {
  var id = UUID()
  var title: String
  var description: String
  var timesCompleted = 0
}

class ModelData: ObservableObject {
  @Published var actitivies: [Activity] = []
}
