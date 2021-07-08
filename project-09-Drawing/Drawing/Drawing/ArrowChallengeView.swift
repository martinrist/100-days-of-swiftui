//
//  ArrowChallengeView.swift
//  Drawing
//
//  Created by Martin Rist on 08/07/2021.
//

import SwiftUI

struct Arrow: Shape {
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

    return path.strokedPath(StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
  }
}

struct ArrowChallengeView: View {
  var body: some View {
    Arrow()
      .frame(width: 300, height: 300)
  }
}

struct ArrowChallengeView_Previews: PreviewProvider {
  static var previews: some View {
    ArrowChallengeView()
  }
}
