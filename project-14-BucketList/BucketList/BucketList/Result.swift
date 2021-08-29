//
//  Result.swift
//  Result
//
//  Created by Martin Rist on 29/08/2021.
//

import Foundation

struct Result: Codable {
  let query: Query
}

struct Query: Codable {
  let pages: [Int: Page]
}

struct Page: Codable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
}
