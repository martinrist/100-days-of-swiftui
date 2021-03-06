//
//  AccessibilityLabelExampleView.swift
//  AccessibilityLabelExampleView
//
//  Created by Martin Rist on 31/08/2021.
//

import SwiftUI

struct AccessibilityLabelExampleView: View {
  let pictures = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096"
  ]

  let labels = [
    "tulips",
    "Frozen tree buds",
    "Sunflowers",
    "Fireworks"]

  @State private var selectedPicture = Int.random(in: 0...3)

  var body: some View {
    Image(pictures[selectedPicture])
      .resizable()
      .scaledToFit()
      .onTapGesture {
        selectedPicture = Int.random(in: 0...3)
      }
      .accessibilityLabel(labels[selectedPicture])
      .accessibilityAddTraits(.isButton)
      .accessibilityRemoveTraits(.isImage)
      .navigationTitle("Accessibility Labels")
  }
}

struct AccessibilityLabelExampleView_Previews: PreviewProvider {
  static var previews: some View {
    AccessibilityLabelExampleView()
  }
}
