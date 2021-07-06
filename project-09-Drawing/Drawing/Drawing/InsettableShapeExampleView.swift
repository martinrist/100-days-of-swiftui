//
//  InsettableShapeExampleView.swift
//  Drawing
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct InsettableArc: InsettableShape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  var insetAmount: CGFloat = 0

  func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment

    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2 - insetAmount,
                startAngle: modifiedStart,
                endAngle: modifiedEnd,
                clockwise: !clockwise)

    return path
  }

  func inset(by amount: CGFloat) -> some InsettableShape {
    var arc = self
    arc.insetAmount += amount
    return arc
  }
}

struct InsettableShapeExampleView: View {
  var body: some View {
    InsettableArc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
      .strokeBorder(Color.green, lineWidth: 50)
      .navigationBarTitle("InsettableShape", displayMode: .inline)
  }
}

struct InsettableShapeExampleView_Previews: PreviewProvider {
  static var previews: some View {
    InsettableShapeExampleView()
  }
}
