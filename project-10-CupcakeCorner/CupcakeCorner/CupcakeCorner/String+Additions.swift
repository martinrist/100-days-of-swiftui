//
//  String+Additions.swift
//  String+Additions
//
//  Created by Martin Rist on 17/08/2021.
//

import Foundation

extension String {

  func isEmptyOrWhitespace() -> Bool {
    self.isEmpty || self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}
