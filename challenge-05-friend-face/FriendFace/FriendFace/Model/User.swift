//
//  User.swift
//  User
//
//  Created by Martin Rist on 23/08/2021.
//

import Foundation

struct User: Codable, Identifiable {
  let id: UUID
  let name: String
  let company: String
  let address: String
  let isActive: Bool
  let about: String
  let tags: [String]
}
