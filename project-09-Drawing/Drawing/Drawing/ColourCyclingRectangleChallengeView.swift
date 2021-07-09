//
//  ColourCyclingRectangleChallengeView.swift
//  Drawing
//
//  Created by Martin Rist on 07/07/2021.
//

import SwiftUI

struct ColourCyclingRectangle: View {
  var amount = 0.0
  var steps = 150
  var gradientEndX: CGFloat
  var gradientEndY: CGFloat

  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        GeometryReader { geom in

          Rectangle()
            .inset(by: CGFloat(value))
            .strokeBorder(LinearGradient(gradient: Gradient(colors: [color(for: value, brightness: 1),
                                                                     color(for: value, brightness: 0.5)]),
                                         startPoint: .top,
                                         endPoint: UnitPoint(x: gradientEndX / geom.size.width,
                                                             y: gradientEndY / geom.size.height)),
                          lineWidth: 2)
        }
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

struct ColourCyclingRectangleChallengeView: View {
  @State private var colourCycle = 0.0
  @State private var gradientEndX = 150.0
  @State private var gradientEndY = 150.0

  var body: some View {
    VStack {

      ColourCyclingRectangle(amount: colourCycle, gradientEndX: gradientEndX, gradientEndY: gradientEndY)
        .frame(width: 300, height: 300)
        .gesture(DragGesture()
                  .onChanged {
          gradientEndX = $0.location.x
          gradientEndY = $0.location.y
        })

      Slider(value: $colourCycle)
    }
  }
}

struct ColourCyclingRectangleChallengeView_Previews: PreviewProvider {
  static var previews: some View {
    ColourCyclingRectangleChallengeView()
  }
}
