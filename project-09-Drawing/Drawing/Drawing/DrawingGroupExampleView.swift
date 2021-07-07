//
//  DrawingGroupExampleView.swift
//  Drawing
//
//  Created by Martin Rist on 07/07/2021.
//

import SwiftUI

struct ColourCyclingCircle: View {
  var amount = 0.0
  var steps = 100

  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Circle()
          .inset(by: CGFloat(value))
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 1),
                                                                   color(for: value, brightness: 0.5)]),
                                       startPoint: .top,
                                       endPoint: .bottom), lineWidth: 2)
      }
    }
    .drawingGroup()
  }

  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(steps) + amount
    if targetHue > 1 {
      targetHue -= 1
    }
    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }

}

struct DrawingGroupExampleView: View {
  @State private var colourCycle = 0.0

  var body: some View {
    VStack {
      ColourCyclingCircle(amount: colourCycle)
        .frame(width: 300, height: 300)

      Slider(value: $colourCycle)
    }
  }
}

struct DrawingGroupExampleView_Previews: PreviewProvider {
  static var previews: some View {
    DrawingGroupExampleView()
  }
}
