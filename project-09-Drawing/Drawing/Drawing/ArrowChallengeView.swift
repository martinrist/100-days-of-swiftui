//
//  ArrowChallengeView.swift
//  Drawing
//
//  Created by Martin Rist on 08/07/2021.
//

import SwiftUI

struct Arrow: Shape {
  var lineWidth: Double

  var animatableData: Double {
    get { lineWidth }
    set { self.lineWidth = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()

    path.move(to: CGPoint(x: rect.maxX / 4, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY * 1/3))
    path.addLine(to: CGPoint(x: 0, y: rect.maxY * 1/3))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 1/3))
    path.addLine(to: CGPoint(x: rect.maxX * 3/4, y: rect.maxY * 1/3))
    path.addLine(to: CGPoint(x: rect.maxX * 3/4, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY))

    return path.strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
  }
}

struct ArrowChallengeView: View {

  @State private var lineWidth = 5.0

  var body: some View {
    VStack {
      Arrow(lineWidth: lineWidth)
        .frame(width: 300, height: 300)
        .animation(.default)

      Spacer()

      Stepper(value: $lineWidth, in: 0...50, step: 5) {
        Text("Line width \(lineWidth, specifier: "%g")")
      }
    }
    .padding()
  }
}

struct ArrowChallengeView_Previews: PreviewProvider {
  static var previews: some View {
    ArrowChallengeView()
  }
}
