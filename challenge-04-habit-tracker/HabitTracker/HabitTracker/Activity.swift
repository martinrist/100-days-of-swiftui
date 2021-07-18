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
  @Published var activities: [Activity] = []
}

extension ModelData {
  static var testData: ModelData = {
    var modelData = ModelData()
    modelData.activities = [Activity(title: "Title 1", description: "Description 1", timesCompleted: 5),
                            Activity(title: "Title 2", description: "Description 2", timesCompleted: 4),
                            Activity(title: "Title 3", description: "Description 3", timesCompleted: 2),
                            Activity(title: "Title 4", description: "Description 4", timesCompleted: 0)
    ]
    return modelData
  }()
}
