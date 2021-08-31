//
//  AccessibilityGroupsExample.swift
//  AccessibilityGroupsExample
//
//  Created by Martin Rist on 31/08/2021.
//

import SwiftUI

struct AccessibilityGroupsExample: View {
  var body: some View {
    VStack {
      Text("Your score is")
      Text("1000")
        .font(.title)
    }
    .accessibilityElement(children: .ignore)
    .accessibilityLabel("Your score is 1000")
    .navigationTitle("Accessibility Groups")
  }
}

struct AccessibilityGroupsExample_Previews: PreviewProvider {
  static var previews: some View {
    AccessibilityGroupsExample()
  }
}
