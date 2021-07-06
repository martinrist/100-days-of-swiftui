//
//  CustomPathsView.swift
//  Drawing
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct PathExampleView: View {
  var body: some View {
    Path { path in
        path.move(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.addLine(to: CGPoint(x: 300, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
    }
    .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    .navigationBarTitle("Path", displayMode: .inline)
  }
}

struct PathExampleView_Previews: PreviewProvider {
  static var previews: some View {
    PathExampleView()
  }
}
