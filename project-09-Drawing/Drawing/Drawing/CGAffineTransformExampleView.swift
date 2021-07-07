//
//  CGAffineTransformExampleView.swift
//  Drawing
//
//  Created by Martin Rist on 07/07/2021.
//

import SwiftUI

struct Flower: Shape {
  // How much to move the petal from the centrw
  var petalOffset: Double = -20

  // How wide to make each petal
  var petalWidth: Double = 100

  func path(in rect: CGRect) -> Path {
    // The path that will hold all petals
    var path = Path()

    for number in stride(from: 0, to: CGFloat.pi * 2, by: .pi / 8) {

      // Rotate the petal by the current loop value
      let rotation = CGAffineTransform(rotationAngle: number)

      // move the petal to be at the centre of the view
      let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2,
                                                              y: rect.height / 2))

      // create a path for this petal using our properties plus a fixed Y and height
      let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset),
                                                 y: 0,
                                                 width: CGFloat(petalWidth),
                                                 height: rect.width / 2))

      // apply our rotation/position transformation to the petal
      let rotatedPetal = originalPetal.applying(position)

      // add it to our main path
      path.addPath(rotatedPetal)
    }
    return path
  }
}

struct CGAffineTransformExampleView: View {

  @State private var petalOffset = -20.0
  @State private var petalWidth = 100.0

  var body: some View {
    VStack {
      Flower(petalOffset: petalOffset, petalWidth: petalWidth)
        .fill(Color.red, style: FillStyle(eoFill: true))

      Text("Offset")
      Slider(value: $petalOffset, in: -40...40)
        .padding([.horizontal, .bottom])

      Text("Width")
      Slider(value: $petalWidth, in: 0...100)
        .padding([.horizontal, .bottom])

    }
  }
}

struct CGAffineTransformExampleView_Previews: PreviewProvider {
  static var previews: some View {
    CGAffineTransformExampleView()
  }
}
