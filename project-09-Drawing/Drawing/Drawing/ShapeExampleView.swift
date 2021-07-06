//
//  ShapesView.swift
//  Drawing
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct Arc: Shape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool

  func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment

    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2,
                startAngle: modifiedStart,
                endAngle: modifiedEnd,
                clockwise: !clockwise)

    return path
  }
}

struct ShapeExampleView: View {
  var body: some View {
    Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
      .stroke(Color.red, lineWidth: 50)
      .frame(width: 300, height: 300)
      .navigationBarTitle("Shape", displayMode: .inline)
  }
}

struct ShapeExampleView_Previews: PreviewProvider {
  static var previews: some View {
    ShapeExampleView()
  }
}
