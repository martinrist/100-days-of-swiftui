//
//  AccessibleSliderExampleView.swift
//  AccessibleSliderExampleView
//
//  Created by Martin Rist on 31/08/2021.
//

import SwiftUI

struct AccessibleSliderExampleView: View {

  @State private var estimate = 25.0

  var body: some View {
    Slider(value: $estimate, in: 0...50)
      .padding()
      .accessibilityValue("\(Int(estimate))")
      .navigationTitle("Accessible `Slider`")
  }
}

struct AccessibleSliderExampleView_Previews: PreviewProvider {
  static var previews: some View {
    AccessibleSliderExampleView()
  }
}
