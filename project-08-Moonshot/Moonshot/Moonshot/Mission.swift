//
//  Mission.swift
//  Moonshot
//
//  Created by Martin Rist on 06/07/2021.
//

import Foundation

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }

  let id: Int
  let launchDate: String?
  let crew: [CrewRole]
  let description: String
}
