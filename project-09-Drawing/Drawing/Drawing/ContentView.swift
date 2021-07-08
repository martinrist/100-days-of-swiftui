//
//  ContentView.swift
//  Drawing
//
//  Created by Martin Rist on 06/07/2021.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        Group {
          NavigationLink(destination: PathExampleView()) {
            Text("`Path` example")
          }
          NavigationLink(destination: ShapeExampleView()) {
            Text("`Shape` example")
          }
          NavigationLink(destination: InsettableShapeExampleView()) {
            Text("`InsettableShape` example")
          }
          NavigationLink(destination: CGAffineTransformExampleView()) {
            Text("`CGAffineTransform` example")
          }
          NavigationLink(destination: ImagePaintExampleView()) {
            Text("`ImagePaint` example")
          }
          NavigationLink(destination: DrawingGroupExampleView()) {
            Text("`drawingGroup()` example")
          }
          NavigationLink(destination: BlendModeExampleView()) {
            Text("`blendMode()` example")
          }
          NavigationLink(destination: AnimatableDataExampleView()) {
            Text("`animatableData` example")
          }
          NavigationLink(destination: AnimatablePairExampleView()) {
            Text("`AnimatablePair` example")
          }
          NavigationLink(destination: SpirographView()) {
            Text("Spirograph example")
          }
        }
        Group {

          NavigationLink(destination: ArrowChallengeView()) {
            Text("Challenge 1 - `Arrow`")
          }
        }
      }
      .navigationBarTitle("Drawing")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
