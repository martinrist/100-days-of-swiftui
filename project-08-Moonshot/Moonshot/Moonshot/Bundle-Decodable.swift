//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Martin Rist on 06/07/2021.
//

import Foundation

extension Bundle {
  func decode(_ file: String) -> [Astronaut] {
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.")
    }

    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file) in bundle.")
    }

    let decoder = JSONDecoder()

    guard let loaded = try? decoder.decode([Astronaut].self, from: data) else {
      fatalError("Failed to decode \(file) from bundle.")
    }

    return loaded
  }
}
