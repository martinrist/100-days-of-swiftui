//
//  Friend.swift
//  Friend
//
//  Created by Martin Rist on 23/08/2021.
//

import Foundation

struct Friend: Codable, Identifiable {
  let id: UUID
  let name: String
}
